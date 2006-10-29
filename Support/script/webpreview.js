/*
	Some scripts for the HTML Output. To be used in conjunction with `../lib/webpreview.sh`.
	
	In Flux: http://macromates.com/wiki/Suggestions/StylingHTMLOutput
*/
function selectTheme(value) {
  TextMate.system("defaults write com.macromates.textmate.webpreview SelectedTheme '" + value + "'", null);
	content = document.getElementById('tm_webpreview_content');
	content.className = value;
	body = document.getElementById('tm_webpreview_body'); // fix to have the body all the way styled (e.g. for black background)
	body.className = value;
}

function hide_header() {
	document.getElementById('tm_webpreview_header').style.display = 'none';
	document.getElementById('tm_webpreview_content').setAttribute('style', 'margin-top: 1em');
	// var header = document.getElementById('tm_webpreview_header');
	// var parent = header.parentNode;
	// parent.removeChild(header);
}
