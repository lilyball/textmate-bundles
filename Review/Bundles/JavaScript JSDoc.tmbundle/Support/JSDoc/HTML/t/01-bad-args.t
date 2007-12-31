use strict;
use Test::More qw(no_plan);
# tests => 6;
use_ok('HTML::Template');

my $tmpl;
eval{$tmpl = HTML::Template->new()};
like($@,
        qr/\QHTML::Template->new called with multiple (or no) template sources specified!/,
        'new() with no args dies');

eval{$tmpl = HTML::Template->new('file')};
like($@,
        qr/\QHTML::Template->new() called with odd number of option parameters/,
        'new() with odd number of args dies');

eval{$tmpl = HTML::Template->new(type => 'filename')};
like($@,
        qr/\Qcalled with 'type' parameter set, but no 'source'!/,
        "new(type => 'filename') dies without source");

eval{$tmpl = HTML::Template->new(
                                 type => 'frobnitz',
                                 source => '../templates/simple.tmpl'
                                 )};
like($@,
        qr/\Qtype parameter must be set to 'filename', 'arrayref', 'scalarref' or 'filehandle'!/,
        'new() dies with invalid type');

eval{$tmpl = HTML::Template->new(filename => 'simple.tmpl',
                                 path => 'templates',
                                 associate => 'Class::With::No::Param'
                                 )};
like($@,
qr/called with associate option, containing object of type.*\Qwhich lacks a param() method!/,
'associate() object with no param() method');

eval{$tmpl = HTML::Template->new(
                                 filename => 'simple.tmpl',
                                 path => 'templates',
                                 'debug'
                                 )};
like($@,
qr/\Qcalled with odd number of option parameters - should be of the form option => value/,
'new() called with option with no value');

=head1 NAME

t/01-bad-args.t

=head1 OBJECTIVE

Test whether constructor fails with appropriate messages if passed bad
or missing arguments.

=cut

__END__
# Below this point are tests which ...
use Test::Exception;

# Applying Test::Exception to this case;
# Note idiosyncratic syntax:
# no parens surrounding block and test description; white space is optional
# block holding method to be tested;
# no comma between block and test description
# test description
dies_ok {$tmpl = HTML::Template->new()} 'new() with no args dies' ;
dies_ok {HTML::Template->new()} 'new() with no args dies';
dies_ok{$tmpl = HTML::Template->new()} 'new() with no args dies' ;
dies_ok{HTML::Template->new()} 'new() with no args dies';

# Customary Test::More syntax; parens around arguments to ok() are optional. 
ok(1, 'return a true value');
ok 1, 'return a true value';

throws_ok { $tmpl = HTML::Template->new('file') }
        qr/\QHTML::Template->new() called with odd number of option parameters/,
        'new() with odd number of args dies';

throws_ok {$tmpl = HTML::Template->new(type => 'filename') }
        qr/\Qcalled with 'type' parameter set, but no 'source'!/,
        "new(type => 'filename') dies without source";

throws_ok { $tmpl = HTML::Template->new(
                                 type => 'frobnitz',
                                 source => '../templates/simple.tmpl'
                                 ) }
        qr/\Qtype parameter must be set to 'filename', 'arrayref', 'scalarref' or 'filehandle'!/,
        'new() dies with invalid type';

throws_ok {$tmpl = HTML::Template->new(filename => 'simple.tmpl',
                                 path => 'templates',
                                 associate => 'Class::With::No::Param'
                                 ) }
qr/called with associate option, containing object of type.*\Qwhich lacks a param() method!/,
'associate() object with no param() method';

throws_ok {$tmpl = HTML::Template->new(
                                 filename => 'simple.tmpl',
                                 path => 'templates',
                                 'debug'
                                 ) }
qr/\Qcalled with odd number of option parameters - should be of the form option => value/,
'new() called with option with no value';

