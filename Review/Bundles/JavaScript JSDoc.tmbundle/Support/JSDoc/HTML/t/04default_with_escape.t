use Test::More qw/no_plan/;
use HTML::Template;

my $text = qq{Foo: <tmpl_var foo default='0' escape=JS>};

my $template = HTML::Template->new(
#        debug => 1,
#        stack_debug => 1,
        scalarref => \$text,
                                  );
$template->param(foo => 1);
my $output = $template->output;

is($output, "Foo: 1");
