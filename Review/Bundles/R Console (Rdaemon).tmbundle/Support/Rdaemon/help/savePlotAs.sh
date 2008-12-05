MYDIR="$HOME/Rdaemon/help/savePlotAs"
SOURCE=${1//file:\/\//}
DEV=$2
if [ -f "$MYDIR"/bin/icf.plist ]; then
	PLERR=$(plutil -lint -s "$MYDIR"/bin/icf.plist)
	if [ ${#PLERR} -gt 0 ]; then
		rm "$MYDIR"/bin/icf.plist
	fi
fi

if [ -f "$MYDIR"/bin/icf.plist ]; then
	DIA=""
else
	cat "$MYDIR"/bin/icf_template.plist > "$MYDIR"/bin/icf.plist
fi

echo -ne "Save Device $2 As:" | perl "$MYDIR/bin/setDevNameHSD.pl"
echo -ne "Enter a valid and non-existing file name without an extension" | perl "$MYDIR/bin/setMessageHSD.pl"

while [ "$TMD_returnCode" != 6 ]
do
	export DIA=$( cat "$MYDIR"/bin/icf.plist | "$DIALOG" -m "$MYDIR"/nibs/saveimage.nib )
	TMD_returnCode=`cat <<-AS | ruby --
    require "#{ENV['TM_SUPPORT_PATH']}/lib/osx/plist"
    print OSX::PropertyList::load(%x{echo -en "$DIA"})["returnCode"]
    AS
    `
	TMD_outfmtValue=`cat <<-AS | ruby --
    require "#{ENV['TM_SUPPORT_PATH']}/lib/osx/plist"
    print OSX::PropertyList::load(%x{echo -en "$DIA"})["outfmtValue"]
    AS
    `
	TMD_filename=`cat <<-AS | ruby --
    require "#{ENV['TM_SUPPORT_PATH']}/lib/osx/plist"
    print OSX::PropertyList::load(%x{echo -en "$DIA"})["filename"].gsub(/^~/,ENV["HOME"])
    AS
    `
	TMD_qualityValue=`cat <<-AS | ruby --
    require "#{ENV['TM_SUPPORT_PATH']}/lib/osx/plist"
    print OSX::PropertyList::load(%x{echo -en "$DIA"})["qualityValue"]
    AS
    `
	TMD_tiffcompValue=`cat <<-AS | ruby --
    require "#{ENV['TM_SUPPORT_PATH']}/lib/osx/plist"
    print OSX::PropertyList::load(%x{echo -en "$DIA"})["tiffcompValue"]
    AS
    `
	TMD_gray=`cat <<-AS | ruby --
    require "#{ENV['TM_SUPPORT_PATH']}/lib/osx/plist"
    print OSX::PropertyList::load(%x{echo -en "$DIA"})["gray"]
    AS
    `
	if [ "$TMD_returnCode" -eq 5 ]; then
		echo "$DIA" >  "$MYDIR"/bin/icf.plist
		TMD_filename=${TMD_filename//~/$HOME}
		if [ ! -d "$TMD_filename" -a ! -f "$TMD_filename.$TMD_outfmtValue" ]; then
			if [ "$TMD_outfmtValue" == "pdf" -o "$TMD_outfmtValue" == "eps" ]; then
				if [ "$TMD_outfmtValue" == "pdf" ]; then
					cat "$SOURCE" > "$TMD_filename.$TMD_outfmtValue"
				fi
				if [ "$TMD_outfmtValue" == "eps" ]; then
					echo "@|.act0815<-dev.cur();dev.set($2);dev.copy2eps(file='"$TMD_filename".eps');dev.set(.act0815);rm(.act0815);" > ~/Rdaemon/r_in
				fi
			else
#				width=$(sips -g pixelWidth "$SOURCE" | awk '{print $2}')
#				height=$(sips -g pixelHeight "$SOURCE" | awk '{print $2}')
#				new_width=$(echo "$width*$TMD_resValue/150" | bc)
#				new_height=$(echo "$height*$TMD_resValue/150" | bc)
				formatOptions=""
				match=""
				grayicc="$HOME/Rdaemon/help/savePlotAs/BlackWhite.icc"
				[[ "$TMD_gray" == "1" ]] && match="-m $grayicc"
				[[ "$TMD_outfmtValue" == "tiff" ]] && formatOptions="-s formatOptions $TMD_tiffcompValue"
				[[ "${TMD_outfmtValue:0:2}" == "jp" ]] && formatOptions="-s formatOptions $TMD_qualityValue"
#				sips -i -z $new_height $new_width $formatOptions $match -s format $TMD_outfmtValue -s dpiHeight $TMD_resValue -s dpiWidth $TMD_resValue "$SOURCE" --out "$TMD_filename.$TMD_outfmtValue"
				sips -i $formatOptions $match -s format $TMD_outfmtValue "$SOURCE" --out "$TMD_filename.$TMD_outfmtValue"
			fi
			exit
		else
			echo -ne "Invalid file name or file already exists." | perl "$MYDIR/bin/setMessageHSD.pl"
		fi
	fi
	if [ "$TMD_returnCode" -eq 2 ]; then
		file=$(osascript -e 'tell application "TextMate"' -e 'activate' -e 'POSIX path of (choose file name with prompt "(without extension)" default name "plot")' -e 'end tell' 2>/dev/null)
		# check for valid file
		if [ -n "$file" ]; then
			echo -ne "$file" | perl "$MYDIR/bin/setFileNameHSD.pl"
		fi
	fi
done
