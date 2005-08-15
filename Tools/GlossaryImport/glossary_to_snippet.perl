#!/usr/bin/perl
#
# version: 1.0 (2005-08-07)
# usage: glossary_to_snippet.perl [-s scope] glossary_folder
#
# creates a new bundle named glossary_folder and converts all
# files in glossary_folder to TextMate snippets by removing
# #indent#, replacing #placeholderstart/end# with the
# corresponding TextMate notation (${n:default value}) and
# setting the tab trigger to the first word of the filename.

use File::Basename;

sub convert_item
{
	my ($file, $prefix) = @_;

	my $name = basename($file);
	$name = "$prefix: $name" if($prefix);
	my $trigger = lc ((basename($file) =~ /(\w*)/)[0]);
	chomp(my $uuid = `uuidgen`);
	my $i = 1;

	$allItems{$uuid} = $name;

	$_ = `cat "$file"`;
	s/[\$`]/\\$&/g;
	s/#indent#//g;
	s/#placeholderstart#(.*?)#placeholderend#/"\${" . $i++ . ":$1}"/ge;
	s/[\\']/\\$&/g;
	return sprintf "{\tname = '%s'; tabTrigger = '%s';\n\tscope = '%s';\n\tcontent = '%s';\n\tuuid = '%s';\n}\n", $name, $trigger, $scope, $_, $uuid;
}

sub convert_dir
{
	my ($src, $dst, $prefix) = @_;
	foreach(($src =~ m/ /) ? glob("\"$src/*\"") :  glob("$src/*"))
	{
		if(/\.(zip|jpg|gif)$/) {
			print " skip $_\n";
		}
		elsif(-f) {
			my $itemName = basename($_);
			open(FILE, "> $dst/$itemName.plist") || die("can't create bundle item: $!");
			print " creating item $itemName\n";
			print FILE &convert_item($_, $prefix);
			close FILE;
		}
		elsif(-d) {
			&convert_dir($_, $dst, ($prefix ? "$prefix / " : "") . basename($_));
		}
		else {
			print "unhandled item : $_\n";
		}
	}
}

sub create_dir
{
	my $dir = shift;
	&create_dir(dirname($dir)) unless(-d $dir);
	mkdir $dir;
}

my $dst = "$ENV{'HOME'}/Library/Application Support/TextMate/Bundles";
$scope = (shift, shift) if(@ARGV[0] eq '-s');

while($ARGV = shift)
{
	my ($bundleName) = basename($ARGV) =~ /([^.]*)/;
	$bundleName .= " Snippets";
	my $bundlePath = "$dst/$bundleName.tmbundle";

	die "$bundleName bundle already exist error" if(-d $bundlePath);
	print "creating $bundleName.tmbundle\n";

	&create_dir("$bundlePath/Snippets");

	%allItems = ( );
	&convert_dir($ARGV, "$bundlePath/Snippets");

	chomp(my $uuid = `uuidgen`);
	open(FILE, "> $bundlePath/info.plist") || die("can't create bundle meta info: $!");
	print " creating bundle meta info\n";
	printf FILE "{ name = \"%s\";\nuuid = \"%s\";\nordering = (\n", $bundleName, $uuid;
	foreach (sort { uc($allItems{$a}) cmp uc($allItems{$b}) } keys %allItems)
	{
		printf FILE "\t\"%s\",\n", $_;
	}
	print FILE ");\n}";
	close FILE;
}
