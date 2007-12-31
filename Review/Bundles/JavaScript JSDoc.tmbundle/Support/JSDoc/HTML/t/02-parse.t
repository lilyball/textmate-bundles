use strict;
use warnings;
use Test::More qw(no_plan);

use HTML::Template;

my ($tmpl_text);

# testing line 1978
$tmpl_text=<<EOT;
         <TMPL_LOOP ESCAPE=HTML NAME=EMPLOYEE_INFO>
             Name: <TMPL_VAR NAME=NAME> <br>
             Job:  <TMPL_VAR NAME=JOB>  <p>
          </TMPL_LOOP>
EOT

eval {
    HTML::Template->new_scalar_ref(\$tmpl_text);
};

like ($@, qr/ESCAPE option invalid/, "Escape not in TMPL_VAR");

# testing line 1981
$tmpl_text=<<EOT;
         <TMPL_LOOP DEFAULT=foo NAME=EMPLOYEE_INFO>
             Name: <TMPL_VAR NAME=NAME> <br>
             Job:  <TMPL_VAR NAME=JOB>  <p>
          </TMPL_LOOP>
EOT

eval {
    HTML::Template->new_scalar_ref(\$tmpl_text);
};

like ($@, qr/DEFAULT option invalid/, "Escape not in TMPL_VAR");

SKIP: {
    skip ("doesn't do the check yet", 2);
# testing line 1984 else
# not quite checking 1984, deserves some sober attention
$tmpl_text=<<EOT;
         <TMPL_HUH NAME=ZAH>
             Name: <TMPL_VAR NAME=NAME> <br>
             Job:  <TMPL_VAR NAME=JOB>  <p>
          </TMPL_HUH>
EOT


ok(HTML::Template->new_scalar_ref(\$tmpl_text, strict => 0), "Ignores invalid TMPL tags with strict off");

#test not working. Get back to it later
eval {
    HTML::Template->new_scalar_ref(\$tmpl_text, strict => 0);
};

like($@, qr/Unknown or unmatched TMPL construct/, "Spits at invalid TMPL tag with strict on");
}  # END SKIP BLOCK

# testing line 1985
$tmpl_text=<<EOT;
         <TMPL_LOOP NAME=EMPLOYEE_INFO>
             Name: <TMPL_VAR NAME=NAME> <br>
             Job:  <TMPL_VAR NAME=JOB>  <p>
          </TMPL_LOOP>
EOT

# too chatty - could re-enable using STDERR-capturing, but it seems
# like a lot of work for a devel-only feature
# ok(HTML::Template->new_scalar_ref(\$tmpl_text, debug => 1), "Debug?");

# attempting to check lines 1540-44
# test using HTML_TEMPLATE_ROOT with path
{
    my $file = 'four.tmpl'; # non-existent file
    local $ENV{HTML_TEMPLATE_ROOT} = "templates";
    eval {
       HTML::Template->new( 
           path => ['searchpath'], 
           filename => $file,
       );
    };
    like ($@, qr/Cannot open included file $file/, 
        "Template file not found");
}

{
    my $file = 'four.tmpl'; # non-existent file
    local $ENV{HTML_TEMPLATE_ROOT} = "templates";
    eval { HTML::Template->new(filename => $file); };
    like ($@, qr/Cannot open included file $file/, 
        "Template file not found");
}

{
    my ($template, $output);
    local $ENV{HTML_TEMPLATE_ROOT} = "templates";
    $template = HTML::Template->new(filename => 'searchpath/three.tmpl');
    $output =  $template->output;
    ok($output =~ /THREE/, 
        "HTML_TEMPLATE_ROOT working without 'path' option being set");
}

=head1 NAME

t/02-parse.t

=head1 OBJECTIVE

Test previously untested code inside C<HTML::Template::_parse()>.  Much
remains to be done.

=cut

