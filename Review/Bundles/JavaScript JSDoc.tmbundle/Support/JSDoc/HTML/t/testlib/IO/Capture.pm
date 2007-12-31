package IO::Capture;

$VERSION = 0.05;
use strict;
use Carp;

=head1 NAME

C<IO::Capture> - Abstract Base Class to build modules to capture output.

=head1 DESCRIPTION

The C<IO::Capture> Module defines an abstract base class that can be
used to build modules that capture output being sent on a filehandle 
such as STDOUT or STDERR.

Several modules that come with the distribution do just that.  
I.e., Capture STDOUT and STDERR.   Also see James Keenan's 
C<IO::Capture::Stdout::Extended> on CPAN.

See L<IO::Capture::Overview> for a 
discussion of these modules and examples of how to build a module to 
sub-class from C<IO::Capture> yourself.   If after reading the overview, 
you would like to build a class from C<IO::Capture>, look here for 
details on the internals.

=head1 METHODS

These are the methods defined in the C<IO::Capture> Module.  This page
will be discussing the module from the point of view of someone who wants 
to build a sub-class of C<IO::Capture>.  

Each method defined in the C<IO::Capture> Module defines a public method, 
that then calls one or more private methods.  I<(Names starting with an 
underscore)>  This allows you to override methods at a finer level of 
granularity, re-using as much of the functionality provided in the module 
as possible.  

Of these internal methods, three are abstract methods that your will 
B<have to> override if you want your module to B<do> anything.  The 
three are C<_start()>,  C<_retrieve_captured_text()>.  and C<_stop()>.

Below are the public methods with the private methods that each uses 
immediately following.

=head2 new

The C<new> method creates a new C<IO::Capture> object, and returns it 
to its caller.  The object is implemented with a hash.  Each key used by 
C<IO::Capture> is named with the class name.  I.e., 'IO::Capture::<key_name>'.  
This is to prevent name clashes with keys added by sub-class authors.
Attributes can be set in the object by passing a hash reference as a single 
argument to new().

    my $capture = IO::Capture->new( { Key => 'value' } );

All elements from this hash will be added to the object, and will be 
available for use by children of IO::Capture.

    my $key = $self->{'Key'};

The internal methods used are:

=over 4

=item C<_initialize()>

C<_initialize> is called as soon as the empty object has been blessed.
It adds the structure to the object that it will need.  The C<IO::Capture>
module adds the following

    IO::Capture::messages      => []
    IO::Capture::line_pointer  =>  1
    IO::Capture::status        =>  'Ready',  # Busy when capturing

=back

=head2 start

The C<start> method is responsible for saving the current state of the
filehandle and or signal hander, and starting the data capture.  

Start cannot be called if there is already a capture in progress.  The
C<stop> must be called first.

These internal methods are called in this order.

=over 4

=item C<_check_pre_conditions>

C<_check_pre_conditions> is used to make sure all the preconditions
are met before starting a capture. The only precondition checked in
C<IO::Capture>, is to insure the "Ready" flag is "on".  I.e., There is 
not already a capture in progress. 

If your module needs to make some checks, and you override this method, make
sure you call the parent class C<_check_pre_conditions> and check the results.  

    sub _check_pre_conditions {
	my $self = shift;

	return unless $self->SUPER::_check_pre_conditions;

An example of something you might want to check would be,
to make sure STDERR is not already I<tied> if you are going to be
using C<tie> on it.

B<Must> return a boolean true for success, or false for failure.
If a failure is indicated, an C<undef> will be returned to the
calling function, and an remaining private methods for C<start> will 
B<not> be run.

=item C<_save_current_configuration()>

C<_save_current_configuration> in C<IO::Capture> will save the state of 
C<STDERR>, C<STDOUT>, and $SIG{__WARN__}.  They are saved in the hash
keys 'IO::Capture::stderr_save', 'IO::Capture::stdout_save', and 
'IO::Capture::handler_save'. 

    # Save WARN handler
    $self->{'IO::Capture::handler_save'} = $SIG{__WARN__};
    # Dup stdout
    open STDOUT_SAVE, ">&STDOUT";
    # Save ref to dup
    $self->{'IO::Capture::stdout_save'} = *STDOUT_SAVE;
    # Dup stderr
    open STDERR_SAVE, ">&STDOUT";
    # Save ref to dup
    $self->{'IO::Capture::stderr_save'} = *STDERR_SAVE;


These saved values can be used in the C<_stop> method to restore the
original value to any you changed.  
    
    $SIG{__WARN__} = $self->{'IO::Capture::handler_save'};
    STDOUT = $self->{'IO::Capture::stdout_save'};
    STDERR = $self->{'IO::Capture::stderr_save'};

B<Must> return a boolean true for success, or false for failure.  
If a failure is indicated, an C<undef> will be returned to the
calling function.

=item C<_start>

B<Start the capture!>  This is only an abstract method in C<IO::Capture>.
It will print a warning if called.  Which should not happen, as the 
author of the sub-class will always be sure to override it with her/his 
own.  :-)

This is the first of the three you need to define.  You will likely 
use tie here.  The included module C<IO::Capture:STDx> (see 
L<IO::Capture::STDx> or other module of your own or from CPAN.
You will read it from the tied module and put it into the object
in C<_retrieve_captured_text>.  See L<_retrieve_captured_text>

B<Must> return a boolean true for success, or false for failure.  
If a failure is indicated, an C<undef> will be returned to the
calling function.

=back

=head2 stop

Stop capturing and return any filehandles and interrupt handlers that were 
changed, to their pre-start state.  This B<must> be called B<before> calling 
C<read()>.  If you are looking for a way to interact with the process on 
the other side of the filehandle, take a look at the L<"Other Modules on CPAN">.  

B<Must> return a boolean true for success, or false for failure.  
If a failure is indicated, an C<undef> will be returned to the
calling function.

=over 4

=item C<_retrieve_captured_text()>

Copy any text captured into the object here.  For example, The modules in this 
package tie the filehandle to the (included) C<IO::Capture::STDx> to collect 
the text.  The data needs to be read out of the tied object before the filehandle 
is untied, so that is done here.  In short, if you need to do any work before
C<_stop> is called, do it here.  The C<_retrieve_capture_text> in this base
class just returns true without doing anything. 

B<Must> return a boolean true for success, or false for failure.  If a failure 
is indicated, an C<undef> will be returned to the calling function.  The C<_stop> 
internal method will be called first.

=item C<_stop>

Do what needs to be done to put things back.  Such as untie filehandles and 
put interrupt handlers back to what they were.  The default C<_stop> method
defined in <IO::Capture> won't do anything, so you should.

B<Must> return a boolean true for success, or false for failure.  If a failure 
is indicated, an C<undef> will be returned to the calling function. 

=back

=head2 read

The C<read> method is responsible for returning the data captured in the
object.  These internal methods will be run, in this order.

=over 4

=item C<_read()>

The internal method used to return the captured text.  If called in I<list
context>, an array will be returned.  (Could be a lot if you captured a lot)
or called in I<scalar context>, the line pointed to by the I<line_pointer> 
will be returned and the I<line_pointer> incremented.

=back

=head1 Other Modules on CPAN

If this module is not exactly what you were looking for, take a look at these. 
Maybe one of them will fit the bill.

=over 4

=item *

IO::Filter - Generic input/output filters for Perl IO handles

=item *

Expect - Expect for Perl 

=item *

Tie::Syslog - Tie a filehandle to Syslog.  If you Tie STDERR, then all 
STDERR errors are automatically caught, or you can debug by Carp'ing to 
STDERR, etc.  (Good for CGI error logging.) 

=item *

FileHandle::Rollback - FileHandle with commit and rollback 

=back

=head1 See Also

L<IO::Capture::Overview>

L<IO::Capture::Stdout>

L<IO::Capture::Stderr>

=head1 AUTHORS

Mark Reynolds
reynolds<at>sgi.com

Jon Morgan
jmorgan<at>sgi.com

=head1 MAINTAINED

Maintained by Mark Reynolds. reynolds<at>sgi.com

=head1 COPYRIGHT

Copyright (c) 2003      Mark Reynolds and Jon Morgan
Copyright (c) 2004-2005 Mark Reynolds
All Rights Reserved.  This module is free software.  It may be used, redistributed
and/or modified under the same terms as Perl itself.

=cut


sub new {
    my $class = shift;
    if (ref $class) {
		carp "WARNING: " . __PACKAGE__ . "::new cannot be called from existing object. (cloned)";
		return;
    }
    my $object = shift || {};
    bless $object, $class;
    $object->_initialize; 
}

sub _check_pre_conditions {
    my $self = shift;

    if( $self->{'IO::Capture::status'} ne "Ready") {
		carp "Start issued on an in progress capture ". ref($self);
		return;
	}

    return 1;
}

sub _initialize {
    my $self = shift;
    if (!ref $self) {
	carp "WARNING: _initialize was called, but not called from a valid object";
	return;
    }

        $self->{'IO::Capture::messages'} = [];
        $self->{'IO::Capture::line_pointer'} = 1;
        $self->{'IO::Capture::status'} = "Ready";
    return $self;
}

sub start {
    my $self = shift;

	if (! $self->_check_pre_conditions) {
		carp "Error: failed _check_pre_confitions in ". ref($self);
		return;
	}

    if (! $self->_save_current_configuration ) { 
		carp "Error saving configuration in " . ref($self);
		return;
    }

    $self->{'IO::Capture::status'} = "Busy";

    if (! $self->_start(@_)) {
		carp "Error starting capture in " . ref($self);
		return;
    }
    return 1;
}

sub stop {
    my $self = shift;

    if( $self->{'IO::Capture::status'} ne "Busy") {
		carp "Stop issued on an unstarted capture ". ref($self);
		return;
	}

    if (! $self->_retrieve_captured_text() ) {
        carp "Error retreaving captured text in " . ref($self);
		return;
    }

    if (!$self->_stop() ) {
		carp "Error return from _stop() " . ref($self) . "\n";
		return;
    }

    $self->{'IO::Capture::status'} = "Ready";

	return 1;
}

sub read {
    my $self = shift;

    $self->_read;
}

#
#  Internal start routine.  This needs to be overriden with instance
#  method
#
sub _start {
    my $self = shift;
    return 1;
}

sub _read {
    my $self = shift;
    my $messages = \@{$self->{'IO::Capture::messages'}};
    my $line_pointer = \$self->{'IO::Capture::line_pointer'};

	if ($self->{'IO::Capture::status'} ne "Ready") {
		carp "Read cannot be done while capture is in progress". ref($self);
		return;
	}

    return if $$line_pointer > @$messages;
	return wantarray ? @$messages :  $messages->[($$line_pointer++)-1];
}

sub _retrieve_captured_text {
    return 1;
    
}

sub _save_current_configuration {
    my $self = shift;
    $self->{'IO::Capture::handler_save'} = $SIG{__WARN__};
    open STDOUT_SAVE, ">&STDOUT";
    $self->{'IO::Capture::stdout_save'} = *STDOUT_SAVE;
    open STDERR_SAVE, ">&STDOUT";
    $self->{'IO::Capture::stderr_save'} = *STDERR_SAVE;
    return $self; 
}

sub _stop {
    my $self = shift;
    return 1;
}

sub line_pointer {
    my $self = shift;
    my $new_number = shift;

    $self->{'IO::Capture::line_pointer'} = $new_number if $new_number;
    return $self->{'IO::Capture::line_pointer'};
}
1;
