/*
	Some scripts for the HTML Output. To be used in conjunction with `../lib/webpreview.sh`.
	
	In Flux: http://macromates.com/wiki/Suggestions/StylingHTMLOutput
*/
function selectTheme(value) {
	var date = new Date();
	// TODO: Save the selected theme permanently
	// Cookies don't work
	// date.setTime(date.getTime() + (365*24*60*60*1000));
	// var expires = "; expires=" + date.toGMTString();
	// document.cookie = "tm_webpreview_content=" + escape(value) + "; expires=" + date.toGMTString();
	content = document.getElementById('tm_webpreview_content');
	content.className = value;
	body = document.getElementById('tm_webpreview_body'); // fix to have the body all the way styled (e.g. for black background)
	body.className = value;
}
