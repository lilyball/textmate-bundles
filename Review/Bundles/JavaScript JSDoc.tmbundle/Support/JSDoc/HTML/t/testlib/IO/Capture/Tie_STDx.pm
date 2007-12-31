package IO::Capture::Tie_STDx;

sub TIEHANDLE {
    my $class = shift;
    bless [], $class;
}

sub PRINTF {
    my $self   = shift;
    my $format = shift;
    $self->PRINT( sprintf( $format, @_ ) );
}

sub PRINT {
     my $self = shift;
     push @$self, join '',@_;
}

sub READLINE {
    my $self = shift;
    return wantarray ? @$self : shift @$self;
}

sub CLOSE {
    my $self = shift;
    return close $self;
}

=head1 NAME

IO::Capture::Tie_STDx;

=head1 SYNOPSIS

    use IO::Capture::Tie_STDx;
    tie  *STDOUT, "IO::Capture::Tie_STDx";

    @$messages = <STDOUT>;

    untie *STDOUT;

=head1 DESCRIPTION

The module C<IO::Capture::Tie_STDx> is a small utility module for use by 
C<IO::Capture> derived modules.  See L<IO::Capture::Overview> It is used to tie STDOUT or STDERR.

=cut

1;
