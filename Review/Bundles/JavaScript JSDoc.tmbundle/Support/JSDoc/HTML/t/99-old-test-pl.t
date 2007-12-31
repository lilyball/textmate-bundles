use strict;
use Test::More qw(no_plan);

use_ok('HTML::Template');

my ($output, $template, $result);

# test a simple template
$template = HTML::Template->new(
                                   path => 'templates',
                                   filename => 'simple.tmpl',
                                   debug => 0
                                  );

$template->param('ADJECTIVE', 'very');
$output =  $template->output;
ok($output !~ /ADJECTIVE/ and $template->param('ADJECTIVE') eq 'very');

# try something a bit larger
$template = HTML::Template->new(
                                path => 'templates',
                                filename => 'medium.tmpl',
                                # debug => 1,
                                      );
$template->param('ALERT', 'I am alert.');
$template->param('COMPANY_NAME', "MY NAME IS");
$template->param('COMPANY_ID', "10001");
$template->param('OFFICE_ID', "10103214");
$template->param('NAME', 'SAM I AM');
$template->param('ADDRESS', '101011 North Something Something');
$template->param('CITY', 'NEW York');
$template->param('STATE', 'NEw York');
$template->param('ZIP','10014');
$template->param('PHONE','212-929-4315');
$template->param('PHONE2','');
$template->param('SUBCATEGORIES','kfldjaldsf');
$template->param('DESCRIPTION',"dsa;kljkldasfjkldsajflkjdsfklfjdsgkfld\nalskdjklajsdlkajfdlkjsfd\n\talksjdklajsfdkljdsf\ndsa;klfjdskfj");
$template->param('WEBSITE','http://www.assforyou.com/');
$template->param('INTRANET_URL','http://www.something.com');
$template->param('REMOVE_BUTTON', "<INPUT TYPE=SUBMIT NAME=command VALUE=\"Remove Office\">");
$template->param('COMPANY_ADMIN_AREA', "<A HREF=administrator.cgi?office_id={office_id}&command=manage>Manage Office Administrators</A>");
$template->param('CASESTUDIES_LIST', "adsfkljdskldszfgfdfdsgdsfgfdshghdmfldkgjfhdskjfhdskjhfkhdsakgagsfjhbvdsaj hsgbf jhfg sajfjdsag ffasfj hfkjhsdkjhdsakjfhkj kjhdsfkjhdskfjhdskjfkjsda kjjsafdkjhds kjds fkj skjh fdskjhfkj kj kjhf kjh sfkjhadsfkj hadskjfhkjhs ajhdsfkj akj fkj kj kj  kkjdsfhk skjhadskfj haskjh fkjsahfkjhsfk ksjfhdkjh sfkjhdskjfhakj shiou weryheuwnjcinuc 3289u4234k 5 i 43iundsinfinafiunai saiufhiudsaf afiuhahfwefna uwhf u auiu uh weiuhfiuh iau huwehiucnaiuncianweciuninc iuaciun iucniunciunweiucniuwnciwe");
$template->param('NUMBER_OF_CONTACTS', "aksfjdkldsajfkljds");
$template->param('COUNTRY_SELECTOR', "klajslkjdsafkljds");
$template->param('LOGO_LINK', "dsfpkjdsfkgljdsfkglj");
$template->param('PHOTO_LINK', "lsadfjlkfjdsgkljhfgklhasgh");

$output = $template->output;
ok($output !~ /<TMPL_VAR/);

# test a simple loop template
$template = HTML::Template->new(
                                path => 'templates',
                                filename => 'simple-loop.tmpl',
                                # debug => 1,
                               );
$template->param('ADJECTIVE_LOOP', [ { ADJECTIVE => 'really' }, { ADJECTIVE => 'very' } ] );

$output =  $template->output;
ok($output !~ /ADJECTIVE_LOOP/ and $output =~ /really.*very/s);

# test a simple loop template
$template = HTML::Template->new(
                                path => 'templates',
                                filename => 'simple-loop-nonames.tmpl',
                                # debug => 1,
                               );
$template->param('ADJECTIVE_LOOP', [ { ADJECTIVE => 'really' }, { ADJECTIVE => 'very' } ] );

$output =  $template->output;
ok($output !~ /ADJECTIVE_LOOP/ and  $output =~ /really.*very/s);

# test a long loop template - mostly here to use timing on.
$template = HTML::Template->new(
                                path => 'templates',
                                filename => 'long_loops.tmpl',
                                # debug => 1,
                               );
$output =  $template->output;
ok(1);

# test a template with TMPL_INCLUDE
$template = HTML::Template->new(
                                path => 'templates',
                                filename => 'include.tmpl',
                                # debug => 1,
                               );
$output =  $template->output;
ok(not (!($output =~ /5/) || !($output =~ /6/)));

# test a template with TMPL_INCLUDE and cacheing.
$template = HTML::Template->new(
                                path => 'templates',
                                filename => 'include.tmpl',
                                cache => 1,
                                # cache_debug => 1,
                                # debug => 1,
                               );
$output =  $template->output;
ok(not (!($output =~ /5/) || !($output =~ /6/)));

# stimulates a cache miss
# system('touch templates/included2.tmpl');

my $template2 = HTML::Template->new(
                                    path => 'templates',
                                    filename => 'include.tmpl',
                                    cache => 1,
                                    # cache_debug => 1,
                                    # debug => 1,
                                   );
$output =  $template->output;
ok(not (!($output =~ /5/) || !($output =~ /6/)));

# test associate
my $template_one = HTML::Template->new(
                                       path => 'templates',
                                       filename => 'simple.tmpl',
                                       # debug => 1,
                                      );
$template_one->param('ADJECTIVE', 'very');

my $template_two = HTML::Template->new (
                                        path => 'templates',
                                        filename => 'simple.tmpl',
                                        associate => $template_one,
                                        # debug => 1,
                                       );

$output =  $template_two->output;
ok($output !~ /ADJECTIVE/ and $output =~ /very/);

# test a simple loop template
my $template_l = HTML::Template->new(
                                     path => 'templates',
                                     filename => 'other-loop.tmpl',
                                     # debug => 1,
                                  );
# $template_l->param('ADJECTIVE_LOOP', [ { ADJECTIVE => 'really' }, { ADJECTIVE => 'very' } ] );

$output =  $template_l->output;
ok($output !~ /INSIDE/);

# test a simple if template
my $template_i = HTML::Template->new(
                                     path => 'templates',
                                     filename => 'if.tmpl',
                                     # debug => 1,
                                  );
# $template_l->param('ADJECTIVE_LOOP', [ { ADJECTIVE => 'really' }, { ADJECTIVE => 'very' } ] );

$output =  $template_i->output;
ok($output !~ /INSIDE/);

# test a simple if template
my $template_i2 = HTML::Template->new(
                                      path => 'templates',
                                      filename => 'if.tmpl',
                                      # stack_debug => 1,
                                      # debug => 1,
                                  );
$template_i2->param(BOOL => 1);

$output =  $template_i2->output;
ok($output =~ /INSIDE/);

# test a simple if/else template
my $template_ie = HTML::Template->new(
                                      path => 'templates',
                                      filename => 'ifelse.tmpl',
                                      # debug => 1,
                                     );

$output =  $template_ie->output;
ok ($output =~ /INSIDE ELSE/);

# test a simple if/else template
my $template_ie2 = HTML::Template->new(
                                       path => 'templates',
                                       filename => 'ifelse.tmpl',
                                       # debug => 1,
                                      );
$template_ie2->param(BOOL => 1);

$output =  $template_ie2->output;
ok($output =~ /INSIDE IF/ and $output !~ /INSIDE ELSE/);

# test a bug involving two loops with the same name
$template = HTML::Template->new(
                                path => 'templates',
                                filename => 'double_loop.tmpl',
                                # debug => 1,
                               );
$template->param('myloop', [
                            { var => 'first'}, 
                            { var => 'second' }, 
                            { var => 'third' }
                           ]
                );
$output = $template->output;
ok($output =~ /David/);

# test escapeing
$template = HTML::Template->new(
                                path => 'templates',
                                filename => 'escape.tmpl',
                                # debug => 1,
                               );
$template->param(STUFF => '<>"\''); #"
$output = $template->output;
ok($output !~ /[<>"']/); #"

# test a simple template, using new param() call format
$template = HTML::Template->new(
                                path => 'templates',
                                filename => 'simple.tmpl',
                                # debug => 1,
                               );

$template->param(
                 {
                  'ADJECTIVE' => 'very'
                 }
                );
$output =  $template->output;
ok($output !~ /ADJECTIVE/ and $output =~ /very/);

# test a recursively including template
eval {
  $template = HTML::Template->new(
                                  path => 'templates',
                                  filename => 'recursive.tmpl',
                                 );
  
  $output =  $template->output;
};

ok(defined($@) and ($@ =~ /recursive/));

# test a template using unless
$template = HTML::Template->new(
                                path => 'templates',
                                filename => 'unless.tmpl',
                                # debug => 1
                               );
$template->param(BOOL => 1);

$output =  $template->output;
ok($output !~ /INSIDE UNLESS/ and $output =~ /INSIDE ELSE/);

# test a template using unless
$template = HTML::Template->new(
                                path => 'templates',
                                filename => 'unless.tmpl',
                                #debug => 1,
                                #debug_stack => 1
                               );
$template->param(BOOL => 0);

$output =  $template->output;
ok($output =~ /INSIDE UNLESS/ and $output !~ /INSIDE ELSE/);

# test a template using loop_context_vars
$template = HTML::Template->new(
                                path => 'templates',
                                filename => 'context.tmpl',
                                loop_context_vars => 1,
                                #debug => 1,
                                #debug_stack => 1
                               );
$template->param(FRUIT => [
                           {KIND => 'Apples'},
                           {KIND => 'Oranges'},
                           {KIND => 'Brains'},
                           {KIND => 'Toes'},
                           {KIND => 'Kiwi'}
                          ]);
$template->param(PINGPONG => [ {}, {}, {}, {}, {}, {} ]);

$output =  $template->output;
ok($output =~ /Apples, Oranges, Brains, Toes, and Kiwi./ and $output =~ /pingpongpingpongpingpong/);

$template = HTML::Template->new(
                                path => 'templates',
                                filename => 'loop-if.tmpl',
                                #debug => 1,
                                #debug_stack => 1
                               );
$output =  $template->output;
ok($output =~ /Loop not filled in/);

$template = HTML::Template->new(
                                path => 'templates',
                                filename => 'loop-if.tmpl',
                                #debug => 1,
                                #debug_stack => 1
                               );
$template->param(LOOP_ONE => [{VAR => "foo"}]);
$output =  $template->output;
ok($output !~ /Loop not filled in/);

# test shared memory - enable by setting the environment variable
# TEST_SHARED_MEMORY to 1.
SKIP: {
  skip "Skipping shared memory cache test.  See README to enable\n", 2
    if (!exists($ENV{TEST_SHARED_MEMORY}) or !$ENV{TEST_SHARED_MEMORY});


  require 'IPC/SharedCache.pm';
  my $template_prime = HTML::Template->new(
                                           filename => 'simple-loop.tmpl',
                                           path => ['templates/'],
                                           shared_cache => 1,
                                           ipc_key => 'TEST',
                                           #cache_debug => 1,
                                          );

  my $template = HTML::Template->new(
                                     filename => 'simple-loop.tmpl',
                                     path => ['templates/'],
                                     shared_cache => 1,
                                     ipc_key => 'TEST',
                                     #cache_debug => 1,
                                    );
  $template->param('ADJECTIVE_LOOP', [ { ADJECTIVE => 'really' }, { ADJECTIVE => 'very' } ] );
  $output =  $template->output;
  ok($output !~ /ADJECTIVE_LOOP/ and $output =~ /really.*very/s);

   my $template_prime2 = HTML::Template->new(
                                            filename => 'simple-loop.tmpl',
                                            path => ['templates/'],
                                            double_cache => 1,
                                            ipc_key => 'TEST',
                                            #cache_debug => 1,
                                     );

   my $template2 = HTML::Template->new(
                                      filename => 'simple-loop.tmpl',
                                      path => ['templates/'],
                                      double_cache => 1,
                                      ipc_key => 'TEST',
                                      #cache_debug => 1,
                                     );
   $template->param('ADJECTIVE_LOOP', [ { ADJECTIVE => 'really' }, { ADJECTIVE => 'very' } ] );
   $output =  $template->output;
   ok($output !~ /ADJECTIVE_LOOP/ and $output =~ /really.*very/s);

  IPC::SharedCache::remove('TEST');
}

# test CGI associate bug    
eval { require 'CGI.pm'; };
SKIP: {
  skip "Skipping associate tests, need CGI.pm to test associate\n", 1
    if ($@);

  my $query = CGI->new('');
  $query->param('AdJecTivE' => 'very');
  $template = HTML::Template->new(
                                     path => 'templates',
                                     filename => 'simple.tmpl',
                                     debug => 0,
                                     associate => $query,
                                    );
  $output =  $template->output;
  ok($output =~ /very/);
}

# test subroutine as VAR
$template = HTML::Template->new(
                                path => 'templates',
                                filename => 'simple.tmpl',
                                debug => 0,
                               );
$template->param(ADJECTIVE => sub { return 'v' . '1e' . '2r' . '3y'; });
$output =  $template->output;
ok($output =~ /v1e2r3y/);

# test cache - non automated, requires turning on debug watching STDERR!
$template = HTML::Template->new(
                                path => ['templates/'],
                                filename => 'simple.tmpl',
                                cache => 1,
                                # cache_debug => 1,
                                debug => 0,
                               );
$template->param(ADJECTIVE => sub { return 'v' . '1e' . '2r' . '3y'; });
$output =  $template->output;
$template = HTML::Template->new(
                                path => ['templates/'],
                                filename => 'simple.tmpl',
                                cache => 1,
                                # cache_debug => 1,
                                debug => 0,
                               );
ok($output =~ /v1e2r3y/);

# test URL escapeing
$template = HTML::Template->new(
                                path => 'templates',
                                filename => 'urlescape.tmpl',
                                # debug => 1,
                                # stack_debug => 1,
                               );
$template->param(STUFF => '<>"; %FA'); #"
$output = $template->output;
ok($output !~ /[<>"]/); #"

# test query()
$template = HTML::Template->new(
                                path => 'templates',
                                filename => 'query-test.tmpl',
                               );
my %params = map {$_ => 1} $template->query(loop => 'EXAMPLE_LOOP');

my @result;
eval {
  @result = $template->query(loop => ['EXAMPLE_LOOP', 'BEE']);
};

ok($@ =~ /error/ and
   $template->query(name => 'var') eq 'VAR' and
   $template->query(name => 'EXAMPLE_LOOP') eq 'LOOP' and
   exists $params{bee} and
   exists $params{bop} and
   exists $params{example_inner_loop} and
   $template->query(name => ['EXAMPLE_LOOP', 'EXAMPLE_INNER_LOOP']) eq 'LOOP'
  );   

# test query()
$template = HTML::Template->new(                                
                                path => 'templates',
                                filename => 'query-test2.tmpl',
                               );
my %p = map {$_ => 1} $template->query(loop => ['LOOP_FOO', 'LOOP_BAR']);
ok(exists $p{foo} and exists $p{bar} and exists $p{bash});

# test global_vars
$template = HTML::Template->new(                                
                                path => 'templates',
                                filename => 'globals.tmpl',
                                global_vars => 1,
                               );
$template->param(outer_loop => [{loop => [{'LOCAL' => 'foo'}]}]);
$template->param(global => 'bar');
$template->param(hidden_global => 'foo');
$result = $template->output();
ok($result =~ /foobar/);

$template = HTML::Template->new(                                
                                path => 'templates',
                                filename => 'vanguard1.tmpl',
                                vanguard_compatibility_mode => 1,
                               );
$template->param(FOO => 'bar');
$template->param(BAZ => 'bop');
$result = $template->output();
ok($result =~ /bar/ and $result =~ /bop/);

$template = HTML::Template->new(                           
                                path => 'templates',
                                filename => 'loop-context.tmpl',
                                loop_context_vars => 1,
                               );
$template->param(TEST_LOOP => [ { NUM => 1 } ]);
$result = $template->output();
ok($result =~ /1:FIRST::LAST:ODD/);

# test a TMPL_INCLUDE from a later path directory back up to an earlier one
# when using the search_path_on_include option
$template = HTML::Template->new(
                                path => ['templates/searchpath/','templates/'],
                                search_path_on_include => 1,
                                filename => 'include.tmpl',
                               );
$output =  $template->output;
ok($output =~ /9/ and $output =~ /6/);

# test no_includes
eval {
  $template = HTML::Template->new(
                                  path => ['templates/'],
                                  filename => 'include.tmpl',
                                  no_includes => 1,
                                 );
};
ok(defined $@ and $@ =~ /no_includes/);

# test file cache - non automated, requires turning on debug watching STDERR!
$template = HTML::Template->new(
                                path => ['templates/'],
                                filename => 'simple.tmpl',
                                file_cache_dir => './blib/temp_cache_dir',
                                file_cache => 1,
                                #cache_debug => 1,
                                #debug => 0,
                               );
$template->param(ADJECTIVE => sub { "3y"; });
$output =  $template->output;
$template = HTML::Template->new(
                                path => ['templates/'],
                                filename => 'simple.tmpl',
                                file_cache_dir => './blib/temp_cache_dir',
                                file_cache => 1,
                                #cache_debug => 1,
                                #debug => 0,
                               );
ok($output =~ /3y/);

my $x;
$template = HTML::Template->new(filename => 'templates/simple-loop.tmpl',
                                filter => {
                                           sub => sub {
                                               $x = 1;
                                               for (@{$_[0]}) {
                                                   $_ = "$x : $_";
                                                   $x++;
                                               }
                                           },
                                           format => 'array',
                                          },
                                file_cache_dir => './blib/temp_cache_dir',
                                file_cache => 1,
                                global_vars => 1,
                               );
$template->param('ADJECTIVE_LOOP', [ { ADJECTIVE => 'really' }, { ADJECTIVE => 'very' } ] );
$output =  $template->output;
ok($output =~ /very/);

$template = HTML::Template->new(filename => './templates/include_path/a.tmpl');
$output =  $template->output;
ok($output =~ /Bar/);

open(OUT, ">blib/test.out") or die $!;
$template = HTML::Template->new(filename => './templates/include_path/a.tmpl');
$template->output(print_to => *OUT);
close(OUT);
open(OUT, "blib/test.out") or die $!;
$output = join('',<OUT>);
close(OUT);
ok($output =~ /Bar/);

my $test = 39; # test with case sensitive params on
my $template_source = <<END_OF_TMPL;
  I am a <TMPL_VAR NAME="adverb"> <TMPL_VAR NAME="ADVERB"> simple template.
END_OF_TMPL
$template = HTML::Template->new(
                                scalarref => \$template_source,
                                case_sensitive => 1,
                                debug => 0
                               );

$template->param('adverb', 'very');
$template->param('ADVERB', 'painfully');
$output =  $template->output;
ok($output !~ /ADVERB/i and 
   $template->param('ADVERB') eq 'painfully' and
   $template->param('adverb') eq 'very' and
   $output =~ /very painfully/);

# test with case sensitive params off
$template_source = <<END_OF_TMPL;
  I am a <TMPL_VAR NAME="adverb"> <TMPL_VAR NAME="ADVERB"> simple template.
END_OF_TMPL
$template = HTML::Template->new(
                                scalarref => \$template_source,
                                case_sensitive => 0,
                                debug => 0
                               );

$template->param('adverb', 'very');
$template->param('ADVERB', 'painfully');
$output =  $template->output;
ok($output !~ /ADVERB/i and
   $template->param('ADVERB') eq 'painfully' and
   $template->param('adverb') eq 'painfully' and
   $output =~ /painfully painfully/);

$template = HTML::Template->new(filename => './templates/include_path/a.tmpl',
                                filter => sub {
                                  ${$_[0]} =~ s/Bar/Zanzabar/g;
                                }
                               );
$output =  $template->output;
ok($output =~ /Zanzabar/);

$template = HTML::Template->new(filename => './templates/include_path/a.tmpl',
                                filter => [
                                           {
                                            sub => sub {
                                              ${$_[0]} =~ s/Bar/Zanzabar/g;
                                            },
                                            format => 'scalar'
                                           },
                                           {
                                            sub => sub {
                                              ${$_[0]} =~ s/bar/bar!!!/g;
                                            },
                                            format => 'scalar'
                                           }
                                          ]
                               );
$output =  $template->output;
ok($output =~ /Zanzabar!!!/);


$template = HTML::Template->new(filename => './templates/include_path/a.tmpl',
                                filter => {
                                           sub => sub {
                                             $x = 1;
                                             for (@{$_[0]}) {
                                               $_ = "$x : $_";
                                               $x++;
                                             }
                                           },
                                           format => 'array',
                                          }
                               );
$output =  $template->output;
ok($output =~ /1 : Foo/);

$template = HTML::Template->new(
                                scalarref => \ "\n<TMPL_INCLUDE templates/simple.tmpl>",
                               );
$template->param(ADJECTIVE => "3y");
$output = $template->output();
ok($output =~ /3y/);

$template = HTML::Template->new(path => ['templates'],
                                filename => 'newline_test1.tmpl',
                                filter => sub {},
                               );
$output = $template->output();
ok($output =~ /STARTincludeEND/);

# test multiline tags
$template = HTML::Template->new(path => ['templates'],
                                filename => 'multiline_tags.tmpl',
                                global_vars => 1,
                               );
$template->param(FOO => 'foo!', bar => [{}, {}]);
$output = $template->output();
ok($output =~ /foo!\n/);
ok($output =~ /foo!foo!\nfoo!foo!/);

# test new() from filehandle
open(TEMPLATE, "templates/simple.tmpl");
$template = HTML::Template->new(filehandle => *TEMPLATE);

$template->param('ADJECTIVE', 'very');
$output =  $template->output;
ok($output !~ /ADJECTIVE/ and $template->param('ADJECTIVE') eq 'very');
close(TEMPLATE);

# test new_() from filehandle
open(TEMPLATE, "templates/simple.tmpl");
$template = HTML::Template->new_filehandle(*TEMPLATE);

$template->param('ADJECTIVE', 'very');
$output =  $template->output;
ok($output !~ /ADJECTIVE/ and $template->param('ADJECTIVE') eq 'very');
close(TEMPLATE);

# test case sensitive loop variables
$template = HTML::Template->new(path => ['templates'],
                                filename => 'case_loop.tmpl',
                                case_sensitive => 1,
                               );
$template->param(loop => [ { foo => 'bar', FOO => 'BAR' } ]);
$output = $template->output();
ok($output =~ /bar BAR/);

# test ifs with code refd
$template = HTML::Template->new(path => ['templates'],
                                filename => 'if.tmpl');
$template->param(bool => sub { 0 });
$output = $template->output();
ok($output !~ /INSIDE/ and $output =~ /unless/);

# test global_vars for loops within loops
$template = HTML::Template->new(path => ['templates'],
				filename => 'global-loops.tmpl',
				global_vars => 1);
$template->param(global => "global val");
$template->param(outer_loop => [
				{ 
				 foo => 'foo val 1',
				 inner_loop => [
						{ bar => 'bar val 1' },
						{ bar => 'bar val 2' },
					       ],
				},
				{
				 foo => 'foo val 2',
				 inner_loop => [
						{ bar => 'bar val 3' },
						{ bar => 'bar val 4' },
					       ],
				}
			       ]);
$output = $template->output;
ok($output =~ /inner loop foo:    foo val 1/ and
   $output =~ /inner loop foo:    foo val 2/);


# test nested include path handling
$template = HTML::Template->new(path => ['templates'],
				   filename => 'include_path/one.tmpl');
$output = $template->output;
ok($output =~ /ONE/ and $output =~ /TWO/ and $output =~ /THREE/);

# test using HTML_TEMPLATE_ROOT with path
{
    local $ENV{HTML_TEMPLATE_ROOT} = "templates";
    $template = HTML::Template->new(
                                    path => ['searchpath'],
                                    filename => 'three.tmpl',
                                   );
    $output =  $template->output;
    ok($output =~ /THREE/);
}

# test __counter__
$template = HTML::Template->new(path              => ['templates'],
				   filename          => 'counter.tmpl',
                                   loop_context_vars => 1);
$template->param(foo => [ {a => 'a'}, {a => 'b'}, {a => 'c'} ]);
$template->param(outer => [ {inner => [ {a => 'a'}, {a => 'b'}, {a => 'c'} ] },
                            {inner => [ {a => 'x'}, {a => 'y'}, {a => 'z'} ] },                           ]);
$output = $template->output;
ok($output =~ /^1a2b3c$/m);
ok($output =~ /^11a2b3c21x2y3z$/m);

# test default
$template = HTML::Template->new(path              => ['templates'],
				   filename          => 'default.tmpl');
$template->param(cl => 'clothes');
$template->param(start => 'start');
$output = $template->output;
ok($output =~ /cause it's getting hard to think, and my clothes are starting to shrink/);

# test invalid <tmpl_var>
eval {
    my $template = HTML::Template->new(scalarref => \'<tmpl_var>');
};
ok($@ =~ /No NAME given/);


# test a case where a different path should stimulate a cache miss
# even though the main template is the same
$template = HTML::Template->new(path => ['templates', 
                                            'templates/include_path'],
                                   filename => 'outer.tmpl',
                                   search_path_on_include => 1,
                                   cache => 1,
                                   # cache_debug => 1,
                                  );
$output = $template->output;
ok($output =~ /I AM OUTER/);
ok($output =~ /I AM INNER 1/);

$template = HTML::Template->new(path => ['templates', 
                                            'templates/include_path2'],
                                   filename => 'outer.tmpl',
                                   search_path_on_include => 1,
                                   cache => 1,
                                   # cache_debug => 1,
                                  );
$output = $template->output;
ok($output =~ /I AM OUTER/);
ok($output =~ /I AM INNER 2/);

# try the same thing with the file cache
$template = HTML::Template->new(path => ['templates', 
                                            'templates/include_path'],
                                   filename => 'outer.tmpl',
                                   search_path_on_include => 1,
                                   file_cache_dir => './blib/temp_cache_dir',
                                   file_cache => 1,
                                   # cache_debug => 1,
                                  );
$output = $template->output;
ok($output =~ /I AM OUTER/);
ok($output =~ /I AM INNER 1/);

$template = HTML::Template->new(path => ['templates', 
                                            'templates/include_path2'],
                                   filename => 'outer.tmpl',
                                   search_path_on_include => 1,
                                   file_cache_dir => './blib/temp_cache_dir',
                                   file_cache => 1,
                                   # cache_debug => 1,
                                  );
$output = $template->output;
ok($output =~ /I AM OUTER/);
ok($output =~ /I AM INNER 2/);

# test javascript escaping
$template = HTML::Template->new(path => ['templates'],
                                            filename => 'js.tmpl');
$template->param(msg => qq{"He said 'Hello'.\n\r"});
$output = $template->output();
is($output, q{\\"He said \\'Hello\\'.\\n\\r\\"});

# test empty filename
eval { $template = $template = HTML::Template->new(path => ['templates'],
                                                   filename => '');
};
like($@, qr/empty filename/);

# test default escaping

ok(!exists $template->{options}->{default_escape}, "default default_escape");

$template = HTML::Template->new(path => ['templates'],
                                            filename => 'default_escape.tmpl',
                                            default_escape => 'UrL');
is($template->{options}->{default_escape}, 'URL');
$template->param(STUFF => q{Joined with space});
$output = $template->output();
like($output, qr{^Joined%20with%20space});

$template = HTML::Template->new(path => ['templates'],
                                            filename => 'default_escape_off.tmpl',
                                            default_escape => 'UrL');
is($template->{options}->{default_escape}, 'URL');
$template->param(STUFF => q{Joined with space});
$output = $template->output();
like($output, qr{^Joined with space});


$template = HTML::Template->new(path => ['templates'],
                                            filename => 'default_escape.tmpl',
                                            default_escape => 'html');
$template->param(STUFF => q{Joined&with"cruft});
$template->param(LOOP => [ { MORE_STUFF => '<&>' }, { MORE_STUFF => '>&<' } ]);
$template->param(a => '<b>');
$output = $template->output();
like($output, qr{^Joined&amp;with&quot;cruft});
like($output, qr{&lt;&amp;&gt;&gt;&amp;&lt;});
like($output, qr{because it's &lt;b&gt;});

eval {
$template = HTML::Template->new(path => ['templates'],
                                            filename => 'default_escape.tmpl',
                                            default_escape => 'wml');
};
like($@, qr/Invalid setting for default_escape/);
