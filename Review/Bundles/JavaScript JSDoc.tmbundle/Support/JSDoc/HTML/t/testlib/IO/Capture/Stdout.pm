package IO::Capture::Stdout;
use Carp;
use base qw/IO::Capture/;
use IO::Capture::Tie_STDx;

sub _start {
	my $self = shift;
	$self->line_pointer(1);
    tie *STDOUT, "IO::Capture::Tie_STDx";
}

sub _retrieve_captured_text {
    my $self = shift;
    my $messages = \@{$self->{'IO::Capture::messages'}};

    @$messages = <STDOUT>;
	#$self->line_pointer(1);
	return 1;
}

sub _check_pre_conditions {
	my $self = shift;

	return unless $self->SUPER::_check_pre_conditions;

	if (tied *STDOUT) {
		carp "WARNING: STDOUT already tied, unable to capture";
		return;
	}
	return 1;
}

sub _stop {
    untie *STDOUT;
}
1;

=head1 NAME

IO::Capture::Stdout - Capture any output sent to STDOUT 

=head1 SYNOPSIS

    # Generic example (Just to give the overall view)
    use IO::Capture::Stdout;

    $capture = IO::Capture::Stdout->new();

    $capture->start();          # STDOUT Output captured
    print STDOUT "Test Line One\n";
    print STDOUT "Test Line Two\n";
    print STDOUT "Test Line Three\n";
    $capture->stop();           # STDOUT output sent to wherever it was before 'start'

    # In 'scalar context' returns next line
    $line = $capture->read;
    print "$line";         # prints "Test Line One"

    $line = $capture->read;
    print "$line";         # prints "Test Line Two"

    # move line pointer to line 1
    $capture->line_pointer(1);

    $line = $capture->read;
    print "$line";         # prints "Test Line One"

    # Find out current line number
    $current_line_position = $capture->line_pointer;

    # In 'List Context' return an array(list)
    @all_lines = $capture->read;

    # More useful example 1 - "Using in module tests"
    #  Note: If you don't want to make users install 
    #        the IO::Capture module just for your tests,
    #        you can just install in the t/lib directory
    #        of your module and use the lib pragma in  
    #        your tests. 

    use lib "t/lib";
    use IO::Capture::Stdout;

    use Test::More;

    my $capture =  IO::Capture::Stdout->new;
    $capture->start

    # execute with a bad parameter to make sure get
    # an error.

    ok( ! $test("Bad Parameter") );

    $capture->stop();



=head1 DESCRIPTION

The module C<IO::Capture::Stdout>, is derived from the abstract class C<IO::Capture>.
See L<IO::Capture>. The purpose of the module (as the name suggests) is to capture 
any output sent to C<STDOUT>.  After the capture is stopped, the STDOUT filehandle 
will be reset to the previous location. E.g., If previously redirected to a file, when 
C<IO::Capture-E<gt>stop> is called, output will start going into that file again.

Note:  This module won't work with the perl function, system(), or any other operation 
       involving a fork().  If you want to capture the output from a system command,
       it is faster to use open() or back-ticks.  

       my $output = `/usr/sbin/ls -l 2>&1`;


=head1 METHODS

=head2 new

=over 4

=item *

Creates a new capture object.  

=item *

An object can be reused as needed, so will only need to do one of these. 

=over 4

=item *

Be aware, any data previously captured will be discarded if a new 
capture session is started.  

=back

=back

=head2 start

=over 4

=item *

Start capturing data into the C<IO::Capture> Object.

=item *

Can B<not> be called on an object that is already capturing.

=item *

Can B<not> be called while STDOUT tied to an object.  

=item *

C<undef> will be returned on an error.

=back

=head2 stop

=over 4

=item *

Stop capturing data and point STDOUT back to it's previous output location
I.e., untie STDOUT

=back

=head2 read

=over 4

=item *

In I<Scalar Context>

=over 4

=item *

Lines are read from the buffer at the position of the C<line_pointer>, 
and the pointer is incremented by one.

    $next_line = $capture->read;

=back

=item *

In I<List Context>

=over 4

=item *

The array is returned.  The C<line_pointer> is not affected.

    @buffer = $capture->read;

=back

=item *

Data lines are returned exactly as they were captured.  You may want 
to use C<chomp> on them if you don't want the end of line character(s)

    while (my $line = $capture->read) {
        chomp $line;
        $cat_line = join '', $cat_line, $line;
    }

=back

=head2 line_pointer

=over 4

=item *

Reads or sets the C<line_pointer>.

    my $current_line = $capture->line_pointer;
    $capture->line_pointer(1);

=back

=head1 SUB-CLASSING

=head2 Adding Features

If you would like to sub-class this module to add a feature (method) or two,
here is a couple of easy steps. Also see L<IO::Capture::Overview>.

=over 4

=item 1

Give your package a name

    package MyPackage;

=item 2

Use this C<IO::Capture::Stdout> as your base class like this:

    package MyPackage;

    use base qw/IO::Capture::Stdout/;

=item 3

Add your new method like this

    package MyPackage;

    use base qw/IO::Capture::Stdout/;

    sub grep {
        my $self = shift;

        for $line (
    }

=back

=head1 See Also

L<IO::Capture::Overview>

L<IO::Capture>

L<IO::Capture::Stderr>


=head1 AUTHORS

Mark Reynolds
reynolds@sgi.com

Jon Morgan
jmorgan@sgi.com

=head1 COPYRIGHT

Copyright (c) 2003, Mark Reynolds. All Rights Reserved.
This module is free software. It may be used, redistributed
and/or modified under the same terms as Perl itself.

=cut
