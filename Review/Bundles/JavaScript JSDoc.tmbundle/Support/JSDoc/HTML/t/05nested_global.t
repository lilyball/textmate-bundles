use Test::More qw/no_plan/;
use HTML::Template;

# test that global-vars works for loops within loops
my $text = <<END;
<tmpl_loop outer>
  <tmpl_loop inner>
    <tmpl_loop hell>
       Foo: <tmpl_var foo>
    </tmpl_loop>
  </tmpl_loop>
</tmpl_loop>
END

my $template = HTML::Template->new(scalarref         => \$text,
                                   die_on_bad_params => 0,
                                   global_vars       => 1);
$template->param(outer => [{foo => 1, inner => [{hell => [{}]}]}]);
my $output = $template->output;

like($output, qr/Foo: 1/);

# test another similar case
my $text2 = <<END;
<TMPL_VAR NAME="BLA">
<TMPL_LOOP NAME=OUTER_LOOP>
        <TMPL_LOOP NAME=INNER_LOOP>
                <TMPL_VAR NAME="BLA">
        </TMPL_LOOP>
</TMPL_LOOP>
END

$template =
  HTML::Template->new(scalarref         => \$text2,
                      die_on_bad_params => 0,
                      global_vars       => 1);

$template->param(BLA => 'bla1');
$template->param(OUTER_LOOP => [{INNER_LOOP => [{INNER_LOOP2 => [
                                                             {BLA4 => 'test'},
                                                 ]
                                                }
                                               ]
                                }
                               ]);
$output = $template->output;
like($output, qr/bla1.*bla1/s);
