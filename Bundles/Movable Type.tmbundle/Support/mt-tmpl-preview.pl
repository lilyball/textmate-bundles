#!/usr/bin/perl -w

# A template preview utility for Movable Type.
# Accepts the input template from stdin.
# Writes resulting output to stdout.
# Expects MT_HOME environment variable to point to MT home directory.
# Expects MT_BLOG to refer to target blog id.
# Accepts "-a" or "--archive" switch to identify type of archive to
# run as ("i" for individual, "m" for monthly, "d" for daily, "w" for
# weekly, "c" for category).

use strict;

my $blog_id;
BEGIN {
    # establish blog id for cases where we process
    # a template from a file...
    $blog_id = $ENV{MT_BLOG};
    my $mt_dir = $ENV{MT_HOME};
    if (!$mt_dir) {
        print "Please specify a MT_HOME shell parameter."; exit;
    }
    chdir $mt_dir;
}

my $lang = $ENV{LANG} || 'en';

use Getopt::Long;
my $archive_type;
my $result = GetOptions ("archive=s" => \$archive_type);

use lib 'lib';
use MT::Bootstrap;
use MT;
use MT::Template::Context;
use MT::Builder;
use MT::Util qw(start_end_week start_end_month start_end_day);
use MT::Template;
use MT::Entry;
use MT::Promise qw(delay);

my $mt = MT->new();

$mt->set_language($lang);

my $template = '';
while (<STDIN>) {
    $template .= $_;
}

if ($template =~ m/<MT_TRANS/) {
    $template = MT->translate_templatized($template);
}

require MT::Blog;
my $blog = MT::Blog->load($blog_id);

if (!$blog) {
    $blog = MT::Blog->new;
    $blog->name("Example Weblog");
    $blog->description("This is an example weblog; to preview against actual data, specify a valid MT_BLOG shell parameter.");
    $blog->id(-1);
}

my $ctx = MT::Template::Context->new;

$ctx->stash('blog',$blog);
$ctx->stash('blog_id',$blog->id);

my @lt = localtime;
my $ts = sprintf("%04d%02d%02d%02d%02d%02d", $lt[5]+1900,$lt[4]+1,$lt[3],$lt[2],$lt[1],$lt[0]);
my $cond = {};
$ctx->{current_timestamp} = $ts;

my $builder = MT::Builder->new;
my $tokens = $builder->compile($ctx, $template);
my ($start, $end);
my $limit = 10;

my $entry;
$entry = MT::Entry->load({ blog_id => $blog_id },
    { limit => 1, 'sort' => 'created_on', status => MT::Entry::RELEASE(),
      direction => 'descend' });
$entry ||= MT::Entry->load({ blog_id => $blog_id },
    { limit => 1, 'sort' => 'created_on', direction => 'descend' });
if (!$entry) {
    # fake it
    $entry = new MT::Entry;
    $entry->blog_id($blog_id);
    $entry->title("Example Entry");
    $entry->text("Lorem ipsum...");
    $entry->created_on($ts);
}

if (!defined $archive_type) {
    # main index; do nothing
} elsif ($archive_type eq 'i') {
    $ctx->{current_archive_type} = 'Individual';
    # populate the last published on the stash
    $ctx->stash('entry', $entry);
} elsif ($archive_type eq 'm') {
    $ctx->{current_archive_type} = 'Monthly';
    ($start, $end) = start_end_month($entry->created_on, $blog);
} elsif ($archive_type eq 'w') {
    $ctx->{current_archive_type} = 'Weekly';
    ($start, $end) = start_end_week($entry->created_on, $blog);
} elsif ($archive_type eq 'd') {
    $ctx->{current_archive_type} = 'Daily';
    ($start, $end) = start_end_day($entry->created_on, $blog);
} elsif ($archive_type eq 'c') {
    $ctx->{current_archive_type} = 'Category';
    require MT::Category;
    require MT::Placement;
    my $cat = $entry->category;
    if (!$cat) {
        my @cats = MT::Category->load({ blog_id => $blog_id });
        foreach my $this_cat (@cats) {
            my @args = ({ blog_id => $blog_id,
                          status => MT::Entry::RELEASE() },
                        { 'join' => [ 'MT::Placement', 'entry_id',
                                      { category_id => $this_cat->id } ] });
            my $count = scalar MT::Entry->count(@args);
            if ($count) {
                $cat = $this_cat;
                last;
            }
        }
    }
    if (!$cat) {
        $cat = new MT::Category;
        $cat->label("Example Category");
        $cat->description("Example category");
    }

    $ctx->stash('archive_category', $cat);
    my $entries = sub {
        my @e = MT::Entry->load({ blog_id => $blog->id,
                                  status => MT::Entry::RELEASE() },
                                { 'join' => [ 'MT::Placement', 'entry_id',
                                  { category_id => $cat->id } ],
                                    limit => $limit });
        \@e;
    };
    $ctx->stash('entries', delay($entries));
}
if ($start && $end) {
    $ctx->{current_timestamp} = $start;
    $ctx->{current_timestamp_end} = $end;
    my $entries = sub {
        my @e = MT::Entry->load({ created_on => [ $start, $end ],
                                  blog_id => $blog->id,
                                  status => MT::Entry::RELEASE() },
                                { range_incl => { created_on => 1 },
                                  limit => $limit });
        \@e;
    };
    $ctx->stash('entries', delay($entries));
}

my $out = $builder->build($ctx, $tokens, $cond);

if ($builder->errstr) {
    print "Template build error: " . $builder->errstr;
    exit;
}
if ($ctx->errstr) {
    print "Context error: " . $ctx->errstr;
    exit;
}

if ($out =~ m!</head>!) {
    my $site_url = $blog->site_url;
    if ($site_url && ($out !~ m/<base /)) {
        $out =~ s!</head>!<base href="$site_url" /></head>!;
    }
}

print $out;
