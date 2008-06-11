
[[ -e "$TM_BUNDLE_SUPPORT"/lib/IPAnames ]] && rm "$TM_BUNDLE_SUPPORT"/lib/IPAnames

cat "$TM_BUNDLE_SUPPORT/lib/IPAnames.txt" | perl -ne '$a=$_;while($a=~m/[\- :\/]/) {$a=~s/(.*?)\t(.*?)[\- :\/](.*)/$1\t$2\n$1\t$3/g;}; $a=~s/[\(\):\x27]//g;$a=~s/\n(.*?)\t\n/\n/mg;print $a' > "$TM_BUNDLE_SUPPORT/lib/IPAnamesIndex.txt"

sqlite3 "$TM_BUNDLE_SUPPORT/lib/IPAnames" <<-SQL
CREATE TABLE nameindex (char TEXT DEFAULT '', word TEXT DEFAULT '');
CREATE TABLE names (char TEXT DEFAULT '', name TEXT DEFAULT '');
.separator "\t"
.import "$TM_BUNDLE_SUPPORT/lib/IPAnamesIndex.txt" nameindex
.separator "\t"
.import "$TM_BUNDLE_SUPPORT/lib/IPAnames.txt" names
CREATE INDEX words_index ON nameindex (word ASC);
CREATE INDEX char_ind_index ON nameindex (char ASC);
CREATE INDEX char_nam_index ON names (char ASC);
.exit
SQL

[[ -e "$TM_BUNDLE_SUPPORT"/lib/IPAnamesIndex.txt ]] && rm "$TM_BUNDLE_SUPPORT"/lib/IPAnamesIndex.txt