#!/usr/bin/perl

#Original by Roger Braunstein - http://www.partlyhuman.com/wordpress/archives/2005/03/10/textmate-actionscript-bundle/

#Updated by Simon Gregory - http://www.helvector.org - Known to work in TextMate 1.1b17 (513 to 790)

my $HELPDIR = $ENV{"TM_FLASH_HELP"};
my $HELPTOC = "help_toc.xml";
my $WORD = $ENV{"TM_CURRENT_WORD"};
my %RESULTS;

my $STYLE = "<style>
body { 
	font-family: Verdana, Arial, Helvetica, sans-serif; 
	font-size: .7em; 
	padding: 5px; 
	background-color: #FFFFFF;
}
a:link { 
	color: #005FA9;
	text-decoration: none;
}
a:visited { 
	color: #A367B1; 
	text-decoration: none; 
}
a:hover, a:visited:hover { 
	background-color: #DDEEFF; 
}
table {
	font-size: 100%;
	border-spacing: 0px 0px;
	border-collapse: collapse;
	border-bottom: solid 1px #B6C0C3;
	border-right: solid 1px #B6C0C3;
}
th {
	font-weight: bold;
	color: #000000;
	background-color: #DEDEDE;
	text-align: left;
	border-top: solid 1px #B6C0C3; 
	border-left: solid 1px #B6C0C3; 
}
td {
	border-top: solid 1px #B6C0C3; 
	border-left: solid 1px #B6C0C3; 
}
table th, table td {
	padding: 0.4em 10px;
	vertical-align: top;
}
table.nav, table.nav th, table.nav td {
	padding: 0px 0px;
	border: 0px;
}
.nav {  
	margin-top: -3px;
	margin-bottom: -3px;
}
</style>";

my $HEAD = "<html><head><title>ActionScript Dictonary Search Results</title><meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">".$STYLE."</head>";
my $HTMLOUT = "";

open(IN, '<', "$HELPDIR/$HELPTOC") || exit print $HEAD."<body><table class=\"nav\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\"><tr><td width=\"100%\" align=\"left\"><p><b>ActionScript 2.0 Language&#160;Reference</b>&nbsp;</p></td></tr></table><br><hr align=\"left\" ><h1>Search failed for ".$WORD."</h1><div class=\"signature\"><p>In order for this command to work TextMate needs to know where to find the ActionScript Dictionary index file. This is set in <strong>Preferences > Advanced > Shell Variables</strong>. Click <strong>+</strong> and name the variable TM_FLASH_HELP with value of the path to the directory containing the help_toc.xml file on your system. Macromedia have made this tricky and the files aren\'t always in the same place.<br><br>Try clicking the following links:<br><br><a href=\"txmt://open?url=file:///Users/Shared/Library/Application Support/Macromedia/Flash 8/en/Configuration/HelpPanel/Help/ActionScriptLangRef/help_toc.xml\">//Users/Shared/Library/Application Support/Macromedia/Flash 8/en/Configuration/HelpPanel/Help/ActionScriptLangRef</a><br><br><a href=\"txmt://open?url=file:///Users/Shared/Library/Application Support/Macromedia/Flash MX 2004/en/Configuration/HelpPanel/Help/ActionScriptLangRef/help_toc.xml\">//Users/Shared/Library/Application Support/Macromedia/Flash MX 2004/en/Configuration/HelpPanel/Help/ActionScriptLangRef</a><br><br><a href=\"txmt://open?url=file:///Applications/Macromedia Flash MX 2004/First Run/HelpPanel/Help/ActionScriptDictionary\">/Applications/Macromedia Flash MX 2004/First Run/HelpPanel/Help/ActionScriptDictionary</a><br><br>If any of the links work (TextMate will open the help_toc.xml file) then copy and paste the link, omitting the /help_toc.xml on the end, to the path of the shell variable.<br><br>Help can be found on the TextMate mailing list.</p></div></body></html>";
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
	#This re-directs TextMate to the right page. Done this way the page assets are available.
   print "<meta http-equiv=\"refresh\" content=\"0; tm-file://$HELPDIR/$RESULTS{$arr[0]}\">";

	#The following will return the whole document as a string - doc root changes so linked assets are lost.
   #system("cat $HELPDIR/$RESULTS{$arr[0]}");
	
	#How to link so that TextMate opens the actual file.
   #print "txmt://open?url=file://$HELPDIR/$RESULTS{$arr[0]}";

   #Trace out the file name.
	#print "file://$HELPDIR/$RESULTS{$arr[0]}";
	#print "tm-file://$HELPDIR/$RESULTS{$arr[0]}";

}
elsif ($#arr > 0)
{
   $HTMLOUT = $HEAD."<body><table class=\"nav\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\"><tr><td width=\"100%\" align=\"left\"><p><b>ActionScript 2.0 Language&#160;Reference</b>&nbsp;</p></td></tr></table><br><hr align=\"left\" ><h1>Search Results for ".$WORD."</h1><div class=\"signature\"><p>";
   for $term (@arr)
   {
      #print qq#<a href="txmt://open?url=file://$HELPDIR/$RESULTS{$term}">$term</a><br/>#;
      $HTMLOUT = $HTMLOUT.qq#<a href="tm-file://$HELPDIR/$RESULTS{$term}">$term</a><br/>#;
   }
	$HTMLOUT = $HTMLOUT."</p></div></body></html>";
	print $HTMLOUT;
}
else
{
	print $HEAD."<body><table class=\"nav\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\"><tr><td width=\"100%\" align=\"left\"><p><b>ActionScript 2.0 Language&#160;Reference</b>&nbsp;</p></td></tr></table><br><hr align=\"left\" ><h1>No Results for ".$WORD."</h1><div class=\"signature\"><p></p></div></body></html>";
}

close IN;