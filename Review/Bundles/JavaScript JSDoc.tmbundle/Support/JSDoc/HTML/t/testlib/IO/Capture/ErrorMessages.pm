package IO::Capture::ErrorMessages;
use Carp;
use base qw/IO::Capture/;
use IO::Capture::Tie_STDx;

sub _start {
    my $self = shift;
    $self->line_pointer(1);
    $SIG{__WARN__} = sub {print STDERR @_;};
    tie *STDERR, "IO::Capture::Tie_STDx";
}

sub _retrieve_captured_text {
    my $self = shift;
    my $messages = \@{$self->{'IO::Capture::messages'}};

    @$messages = <STDERR>;
    return 1;
}

sub _check_pre_conditions {
    my $self = shift;

    return unless $self->SUPER::_check_pre_conditions;

    if (tied *STDERR) {
        # if SIG{__WARN__} is already captured, this carp isn't seen until
        # you read the capture that holds it
        carp "WARNING: STDERR already tied, unable to capture";
        return;
    }
    return 1;
}

sub _stop {
    my $self = shift;

    untie *STDERR;
    $SIG{__WARN__} = $self->{'IO::Capture::handler_save'};
    return 1;
}

1;

=head1 NAME

C<IO::Capture::ErrorMessages> - Capture output from C<STDERR> and C<warn()>

=head1 SYNOPSYS

    # Generic example (Just to give the overall view)
    use IO::Capture::Stderr;

    my $capture = IO::Capture::ErrorMessages->new();
    $capture->start();
    print STDERR "Test Line One\n";
    print STDERR "Test Line Two\n";
    print STDERR "Test Line Three\n";
    warn "Test line Four\n";
    printf STDERR ("Test Line %08d\n", 5);
    $capture->stop();

    $line = $capture->read;
    print "$line";         # prints "Test Line One"

    $line = $capture->read;
    print "$line";         # prints "Test Line Two"

    $capture->line_pointer(4);

    $line = $capture->read;
    print "$line";        # prints "Test Line Four"

    $current_line_position = $capture->line_pointer;

    # More useful example 1 - "Using in module tests"
    #  Note: If you don't want to make users install 
    #        the IO::Capture module just for your tests,
    #        you can just install in the t/lib directory
    #        of your module and use the lib pragma in  
    #        your tests. 

    use lib "t/lib";
    use IO::Capture::ErrorMessages;

    use Test::More;

    my $capture =  IO::Capture::ErrorMessages->new;
    $capture->start

    # execute with a bad parameter to make sure get
    # an error.

    ok( ! $test("Bad Parameter") );

    $capture->stop();

    # More useful example 2 - "Use with GUI like Tk"
    #   If you are calling a CPAN module that may
    # print some messages that you don't want going
    # to the shell window, or being lost, you can 
    # capture them and then put to a log file or
    # print in a text frame

=head1 DESCRIPTION

The module C<IO::Capture::Stderr>, is derived from the abstract class in 
C<IO::Capture>.  L<IO::Capture>  It captures all output sent to STDERR 
and installs a signal handler to capture the output sent via the 
C<warn()> function (and friends - such as C<carp()>).  We primarily use 
it in module tests, where the test will cause some warning to be printed.  
To keep the output from cluttering up the nice neat row of 'ok's.  ;-)

Note:  This module won't work with the perl function, C<system()>, or any 
other operation involing a C<fork()>.  If you want to capture the output 
from a system command, it is faster to use C<open()> or backticks.  

       my $output = `/usr/sbin/ls -l 2>&1`;

=head1 METHODS

=head1 AUTHORS

Mark Reynolds
reynolds@sgi.com

Jon Morgan
jmorgan@sgi.com

=head1 COPYRIGHT

Copyright (c) 2003, Mark Reynolds and Jon Morgan. All Rights Reserved.
This module is free software. It may be used, redistributed and/or 
modified under the same terms as Perl itself.

=cut
