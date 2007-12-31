use strict;
use Test::More qw(no_plan);
# tests => 6;
use_ok('HTML::Template');

my ($output, $template, $result);
my ($fh, $template_string, @template_array,
    $stemplate, $atemplate, $ftemplate, $fhtemplate, $typetemplate);

$template = HTML::Template->new(
    path => 'templates',
    filename => 'simple.tmpl',
    debug => 0
);

open $fh, 'templates/simple.tmpl' 
    or die "Couldn't open simple.tmpl for reading: $!";
{
    local $/;
    $template_string = <$fh>;
    seek $fh, 0, 0;
}
 
@template_array = <$fh>;
seek $fh, 0, 0;

$stemplate = HTML::Template->new_scalar_ref(
    \$template_string,
    debug => 0
);

$atemplate = HTML::Template->new_array_ref(
    \@template_array,
    debug => 0
);

$ftemplate = HTML::Template->new_file(
    'simple.tmpl',
    path => 'templates',
    debug => 0
);

$fhtemplate = HTML::Template->new_filehandle(
    $fh,
    debug => 0
);

$typetemplate = HTML::Template->new(
    type => 'filename',
    path => 'templates',
    source => 'simple.tmpl',
    debug => 0
);

for my $t ($template, $stemplate, $atemplate, $ftemplate,
           $fhtemplate, $typetemplate) {
    $t->param('ADJECTIVE', 'very');
    $output =  $t->output;
    ok( ( $output !~ /ADJECTIVE/ and $t->param('ADJECTIVE') eq 'very' ),
        'simple template passes');
}


=head1 NAME

t/11-non-file-templates.t

=head1 OBJECTIVE

Test whether simple output is correctly created when the template source
is a string, array or a filehandle.

=cut

