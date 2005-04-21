#!/usr/bin/perl

my $HELPDIR = $ENV{"TM_FLASH_HELP"};
my $HELPTOC = "help_toc.xml";
my $WORD = $ENV{"TM_CURRENT_WORD"};
my %RESULTS;

$WORD =~ s/[()]//g;

open(IN, '<', "$HELPDIR/$HELPTOC") || die "please find your Actionscript Dictionary folder in your flash installation and set it to $TM_FLASH_HELP in your TextMate preferences. e.g. /Applications/Macromedia Flash MX 2004/First Run/HelpPanel/Help/ActionScriptDictionary";
INDEX: while(<IN>)
{
   if (m#href="([^"]+)"\s+name="([^"]+)"#)
   {
      my $url = $1;
      my $term = $2;
      if ($term =~ /^(\w+\.)?$WORD\(\)/i)
      {
         if ($term)
         {
            open(IN2, '<', "$HELPDIR/$url") || die "read error in $HELPDIR/$url";
            my @lines = <IN2>;
            my $helpcontents = join("",@lines);
            
            $helpcontents =~ m|Usage</h4>(.+?)<h4>|s;
            $_ = $1;
            s|[\r\n]||g;
            s|<br>|\n|g;
            s|<.+?>||g;

            print $term . "\n" . $_;
            
            close(IN2);
            last INDEX;
         }
      }
   }
}

close IN;