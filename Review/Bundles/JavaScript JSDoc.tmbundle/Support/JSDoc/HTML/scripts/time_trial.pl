#!/usr/bin/perl -w

# this is a little script I use to test the timing behavior of various
# options in HTML::Template;;

# set this to wherever your test area is
require '../Template.pm';

# an array of template files to test against and params to fill in
 my %templates = (
                   simple => [
                             '../templates/simple.tmpl',
                             {}                            
                            ],
                  include => [
                              '../templates/include.tmpl'
                             ],
                  medium => [
                             '../templates/medium.tmpl',
                             {
                              'ALERT', 'I am alert.',
                              'COMPANY_NAME', "MY NAME IS",
                              'COMPANY_ID', "10001",
                              'OFFICE_ID', "10103214",
                              'NAME', 'SAM I AM',
                              'ADDRESS', '101011 North Something Something',
                              'CITY', 'NEW York',
                              'STATE', 'NEw York',
                              'ZIP','10014',
                              'PHONE','212-929-4315',
                              'PHONE2','',
                              'SUBCATEGORIES','kfldjaldsf',
                              'DESCRIPTION',"dsa;kljkldasfjkldsajflkjdsfklfjdsgkfld\nalskdjklajsdlkajfdlkjsfd\n\talksjdklajsfdkljdsf\ndsa;klfjdskfj",
                              'WEBSITE','http://www.assforyou.com/',
                              'INTRANET_URL','http://www.something.com',
                              'REMOVE_BUTTON', "<INPUT TYPE=SUBMIT NAME=command VALUE=\"Remove Office\">",
                              'COMPANY_ADMIN_AREA', "<A HREF=administrator.cgi?office_id=office_id&command=manage>Manage Office Administrators</A>",
                              'CASESTUDIES_LIST', "adsfkljdskldszfgfdfdsgdsfgfdshghdmfldkgjfhdskjfhdskjhfkhdsakgagsfjhbvdsaj hsgbf jhfg sajfjdsag ffasfj hfkjhsdkjhdsakjfhkj kjhdsfkjhdskfjhdskjfkjsda kjjsafdkjhds kjds fkj skjh fdskjhfkj kj kjhf kjh sfkjhadsfkj hadskjfhkjhs ajhdsfkj akj fkj kj kj  kkjdsfhk skjhadskfj haskjh fkjsahfkjhsfk ksjfhdkjh sfkjhdskjfhakj shiou weryheuwnjcinuc 3289u4234k 5 i 43iundsinfinafiunai saiufhiudsaf afiuhahfwefna uwhf u auiu uh weiuhfiuh iau huwehiucnaiuncianweciuninc iuaciun iucniunciunweiucniuwnciwe",
                              'NUMBER_OF_CONTACTS', "aksfjdkldsajfkljds",
                              'COUNTRY_SELECTOR', "klajslkjdsafkljds",
                              'LOGO_LINK', "dsfpkjdsfkgljdsfkglj",
                              'PHOTO_LINK', "lsadfjlkfjdsgkljhfgklhasgh",
                             }
                            ],
                 long_loop => [ '../templates/long_loops.tmpl',
                                {}
                              ],
                loop_if => [ '../templates/loop-if.tmpl',
                                {LOOP_ONE => [{VAR => 'foo'}]}
                            ]

                );

# a hash of option hashes to test
my %options = (
               'no cache' => {},
               #'simple cache' => { cache => 1 },
               # 'shared cache' => { shared_cache => 1, cache => 1 },
               'file cache' => { file_cache => 1, 
                                 file_cache_dir => './file_cache' },
#               'simple cache, no_includes' => { cache => 1, no_includes => 1},
#               'blind cache' => { blind_cache => 1},
              );

# number of times over each template
my $n = 100;
#open(OUT, ">test.out");

foreach my $template (keys %templates) {
  print "\nTESTING : $template : $n iterations\n\n";

  foreach my $option (keys %options) {
    my $start_time = (times)[0];
    for (my $x = 0; $x < $n; $x++) {
      my $template = HTML::Template->new(filename => $templates{$template}->[0],
                                         %{$options{$option}}
                                        );
      foreach my $name (keys %{$templates{$template}->[1]}) {
        $template->param($name => $templates{$template}->[1]->{$name});
      }
      my $result = $template->output;
      #print OUT $result;
      #$template->output(print_to => *OUT);
    }

    my $end_time = (times)[0];
    print "$option : average iteration in " . (($end_time - $start_time) / $n) . " seconds\n";
  }
}

