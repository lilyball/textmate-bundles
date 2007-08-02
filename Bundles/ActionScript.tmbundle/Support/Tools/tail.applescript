tell app "Terminal"
  activate
  do script "tail -f $HOME/Library/Preferences/Macromedia/Flash\\ Player/Logs/flashlog.txt"
end tell