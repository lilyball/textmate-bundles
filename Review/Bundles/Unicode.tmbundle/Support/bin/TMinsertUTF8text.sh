cat<<-AS | iconv -f UTF-8 -t MACROMAN | osascript --
tell app "TextMate" to insert «data utf8$1» as Unicode text
AS