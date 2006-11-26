#!/usr/bin/perl
my $JSFLPATH = "/tmp/testmovie.jsfl";

my $flapath = $ENV{"TM_SELECTED_FILE"};
(my $flacolons = $flapath) =~ s|/|:|g;

open (JSFL, ">", $JSFLPATH) || die "couldn't write to $JSFLPATH";
print JSFL <<EOF;
fl.outputPanel.clear();


var isOpen = false;
var doc;
for (doc in fl.documents)
{
   if (fl.documents[doc].path == $flacolons)
   {
      isOpen = true;
      break;
   }
}

if (isOpen) 
var doc = fl.getDocumentDOM();
fl.trace(doc.path + doc.name);
//fl.openDocument("file://$ENV{"TM_SELECTED_FILE"}");


EOF
close JSFL;
print `open $JSFLPATH`;