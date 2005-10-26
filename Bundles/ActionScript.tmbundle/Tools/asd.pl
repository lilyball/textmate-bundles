#!/usr/bin/perl

my $HELPDIR = $ENV{"TM_FLASH_HELP"};
my $HELPTOC = "help_toc.xml";
my $WORD = $ENV{"TM_CURRENT_WORD"};
my %RESULTS;

open(IN, '<', "$HELPDIR/$HELPTOC") || die "please find your Actionscript Dictionary folder in your flash installation and set it to $TM_FLASH_HELP in your TextMate preferences. e.g. /Applications/Macromedia Flash MX 2004/First Run/HelpPanel/Help/ActionScriptDictionary";
while(<IN>)
{
   if (m#href="([^"]+)"\s+name="([^"]+)"#)
   {
      my $url = $1;
      my $term = $2;
      if ($term =~ /$WORD/i)
      {
         if ($term)
         {
            $RESULTS{$term} = $url;
         }
      }
   }
}


my @arr = sort(keys(%RESULTS));
if ($#arr == 0)
{
   print "<base href='tm-file://$HELPDIR'>";
   system("cat '$HELPDIR/$RESULTS{$arr[0]}'");
}
elsif ($#arr > 0)
{
   for $term (@arr)
   {
      print qq#<a href="tm-file://$HELPDIR/$RESULTS{$term}">$term</a><br/>#;
   }
}
else
{
   print "No Results for <b>$WORD</b>";
}

close IN;
