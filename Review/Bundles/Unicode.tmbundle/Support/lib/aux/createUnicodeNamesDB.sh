
[[ -e "$TM_BUNDLE_SUPPORT"/lib/UNInames ]] && rm "$TM_BUNDLE_SUPPORT"/lib/UNInames

zcat "$TM_BUNDLE_SUPPORT/lib/UnicodeData.txt.zip" | perl -ne '$a=$_;@d=split(/;/,$a);$a=$d[0]."\t".$d[1];if ($a!~/\t</ && $a!~/CJK/ && $a!~/VARIATION/) {while($a=~m/[\- :\/]/) {$a=~s/(.*?)\t(.*?)[\- :\/](.*)/$1\t$2\n$1\t$3/g;}; $a=~s/[\(\):\x27]//g;$a=~s/\n(.*?)\t\n/\n/mg;print "$a\n"}' > "$TM_BUNDLE_SUPPORT/lib/UNInamesIndex.txt"

zcat "$TM_BUNDLE_SUPPORT/lib/UnicodeData.txt.zip" | perl -ne '$a=$_;@d=split(/;/,$a);$a=$d[0]."\t".$d[1];if ($a!~/\t</ && $a!~/CJK/ && $a!~/VARIATION/) {print "$a\n"}' > "$TM_BUNDLE_SUPPORT/lib/UNInames.txt"

sqlite3 "$TM_BUNDLE_SUPPORT/lib/UNInames" <<-SQL
CREATE TABLE nameindex (char TEXT DEFAULT '', word TEXT DEFAULT '');
CREATE TABLE names (char TEXT DEFAULT '', name TEXT DEFAULT '');
.separator "\t"
.import "$TM_BUNDLE_SUPPORT/lib/UNInamesIndex.txt" nameindex
.separator "\t"
.import "$TM_BUNDLE_SUPPORT/lib/UNInames.txt" names
CREATE INDEX words_index ON nameindex (word ASC);
CREATE INDEX char_ind_index ON nameindex (char ASC);
CREATE INDEX char_nam_index ON names (char ASC);
.exit
SQL

[[ -e "$TM_BUNDLE_SUPPORT"/lib/UNInamesIndex.txt ]] && rm "$TM_BUNDLE_SUPPORT"/lib/UNInamesIndex.txt
[[ -e "$TM_BUNDLE_SUPPORT"/lib/UNInames.txt ]] && rm "$TM_BUNDLE_SUPPORT"/lib/UNInames.txt