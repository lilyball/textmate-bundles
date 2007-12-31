use strict;
use warnings;
use Test::More 
# qw(no_plan);
tests => 4;

use_ok('HTML::Template');

my ($template);

eval { $template = HTML::Template->new(
        path => ['templates/'],
        filename => 'simple.tmpl',
#        file_cache_dir => './blib/temp_cache_dir',
        file_cache_dir => '',
        file_cache => 1,
        #cache_debug => 1,
        #debug => 0,
    );
};
like ($@, qr/^You must specify the file_cache_dir option/, 
    "file_cache_dir option fails due to zero-length string");

eval { $template = HTML::Template->new(
        path => ['templates/'],
        filename => 'simple.tmpl',
        file_cache_dir => './blib/temp_cache_dir',
        file_cache => ,   # missing value; should generate error
        #cache_debug => 1,
        #debug => 0,
    );
};
like ($@, qr/HTML::Template->new\(\) called with odd number of option parameters - should be of the form option => value/, 
    "odd number of arguments causes constructor to fail");

eval { $template = HTML::Template->new(
        path => ['templates/'],
        filename => 'simple.tmpl',
        file_cache_dir => './blib/temp_cache_dir',
        file_cache => undef,   # 'undef' counts as a missing value; should generate error
        #cache_debug => 1,
        #debug => 0,
    );
};
like ($@, qr/HTML::Template->new\(\) called with odd number of option parameters - should be of the form option => value/, 
    "odd number of arguments causes constructor to fail");

=head1 NAME

t/06-file-cache-dir.t

=head1 OBJECTIVE

Test edge cases in use of C<file_cache> and C<file_cache_dir> options 
to constructor C<HTML::Template::new()>.  Example:  test case where 
C<file_cache> option is set to C<undef> but a C<file_cache_dir> value is
provided; examine error message.

=cut

