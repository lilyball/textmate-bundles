use ExtUtils::MakeMaker;

# if this is Perl 5.8.0 then we need to check that the locale isn't
# set to something UTF8-ish since that breaks this perl.  More to the
# point, it breaks HTML::Template during 'make test' which leads to
# the erroneous belief that the problem is in HTML::Template.
if ($] >= 5.008) {    
    my $perl = join('.', (map { ord($_) } split("", $^V, 3)));
    if ($perl eq '5.8.0' and $ENV{LANG} and $ENV{LANG} =~ /UTF-?8/i) {
        die <<END;

!!! Broken Perl Installation Detected !!!

Your version of Perl (v5.8.0) must not be used with a UTF-8 locale
setting.  You can fix this problem by either upgrading Perl to v5.8.1
or later or by choosing a non-UTF-8 LANG setting (ex: en_US).  Redhat
Linux users will find this setting in /etc/sysconfig/i18n.

END
    }
}

# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'	=> 'HTML::Template',
    'VERSION_FROM' => 'Template.pm', # finds $VERSION
    'PREREQ_PM' => { 'Carp'       => 0, 
                     'File::Spec' => 0.82, 
                     'Digest::MD5'=> 0,
                     'Test::More' => 0,
                     'Scalar::Util' => 0,
                   },
);
