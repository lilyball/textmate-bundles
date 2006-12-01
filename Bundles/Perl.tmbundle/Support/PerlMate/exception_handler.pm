package exception_handler;

use Exporter;
use File::Spec;
use File::Basename;
use CGI::Util qw/escape unescape/;
use base qw(Exporter);
use vars qw($VERSION @EXPORT);
no warnings;
use strict;

our $VERSION = '0.01';
our @EXPORT  = qw(die warn);

BEGIN {
 	*CORE::GLOBAL::die = \&__PACKAGE__::die;
}

sub id {
	my $level = shift;
	my ($pack, $file, $line) = caller($level);
	my ($dev, $dirs, $id) = File::Spec->splitpath($file);
	return ($file, $line);
}

sub quote {
    my $str = shift;
    $str =~ s/([^A-Za-z0-9])/sprintf("%%%02X", ord($1))/seg;
    return $str;
}

sub die {
    my $message = join('', @_);
    if ($^S) {
        Carp::croak $message;
    }
    else {
        my $error_fd = $ENV{"TM_ERROR_FD"};
    	chomp($message);
    	my ($file, $line) = id(1);
        my $url = "";
        my $display_name = "";
        if ($file ne "-") {
            $display_name = basename($file);
            $url = 'url=file://' . quote($file) . '&amp;';
        }
        else {
            $url = "";
            $display_name = 'untitled';
        }
        open (TM_ERROR_FD, ">&=$error_fd");
        print TM_ERROR_FD "<div id='exception_report' class='framed'>\n";
        print TM_ERROR_FD "<p id='exception'>$message</p>\n";
        print TM_ERROR_FD "<blockquote><table border='0' cellspacing='0' cellpadding='0'>\n";
    	print TM_ERROR_FD '<tr><td>in <a href="txmt://open?' . $url . 'line=$line"> ' . $display_name . "</a> at line $line<td></tr>\n" ;
    	print TM_ERROR_FD "</table></blockquote></div>";
    	print TM_ERROR_FD "</div>";
    	exit($!);
    }
}