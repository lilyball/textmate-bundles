. "$TM_BUNDLE_SUPPORT"/bin/rebuild_help_index.sh


cat "$TM_BUNDLE_SUPPORT"/help.pkgs | sort -f | ruby -e '
	isDIALOG2 = ! ENV["DIALOG"].match(/2$/).nil?
	require File.join(ENV["TM_SUPPORT_PATH"], "lib/ui.rb")
	require File.join(ENV["TM_SUPPORT_PATH"], "lib/exit_codes.rb")
	words = STDIN.read().split("\n")
	if isDIALOG2
		TextMate::UI.complete(words)
	else
		index=TextMate::UI.menu(words)
		if index != nil
			print words[index]
		else
			TextMate.exit_discard()
		end
	end
	exit 203
'