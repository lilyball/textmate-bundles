#!/usr/bin/perl

# Hideous hack to take to output of entitynav.py and format it as a HTML popup.
# (c) 2005. Eric Hsu.

my $head = <<END; 
<html>
<head>
<!--
This file retrieved from the JS-Examples archives
http://www.js-x.com
1000s of free ready to use scripts, tutorials, forums.
Author: James  - 0
-->
</head>
<body onload="window.resizeTo(800,80);"><script language=javascript>
<!-- 
function jumpTo() { 
var new_local = document.jump.local.value;
top.location.replace(new_local);
window.close();
}
-->
</script>
<font style="font-size:11px">$ENV{"TM_FILEPATH"}</font>
<form name="jump">
<select name="local" onChange="jumpTo(); return false;">
END

my $foot = <<END;
</select>
</form>
</body>
</html>
END

my $url = 'txmt://open?url=file://' . $ENV{"TM_FILEPATH"};
my $results="<option value=\"$url\">Special Items for " . $ENV{"TM_FILENAME"} . "</option>";; 
my ($line,$title);

while (<>) {
	($line,$title)=/^(.*?)\:(.*)$/;
	$title = space_entitized($title);
	$results .= "<option value=\"$url" . "&amp;line=" . $line . "\">$title</option>";
}

print $head . $results . $foot;


sub space_entitized {
	my $in = shift;
	
	$in =~ s/\t/    /g;
	$in =~ s/\ /&nbsp;/g;
	
	return $in;
}
