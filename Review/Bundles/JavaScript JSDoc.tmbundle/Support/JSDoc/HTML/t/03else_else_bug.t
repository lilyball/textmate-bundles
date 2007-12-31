
use Test::More qw/no_plan/;
use HTML::Template;

my $text = qq{Before.  <TMPL_IF NAME="TEST"> 1.  <TMPL_ELSE> 2.  <TMPL_ELSE> 3.  </TMPL_IF> After.};

eval {
    my $template = HTML::Template->new(
        debug => 0,
        scalarref => \$text,
    );
};
like($@, qr/found second <TMPL_ELSE> tag/, 
     "including 2 <tmpl_else> tags for one tmpl_if should throw an error");
