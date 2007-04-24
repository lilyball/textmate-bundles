/* 
Capture window close events and test to see if the page has any swf's embedded with 
a "closeWarning()" callback registered to ExternalInterface.
*/
window.onbeforeunload = function()
{

	var warning='';
	var closeCaptureSwf = document.${TM_NEW_FILE_BASENAME} || window.${TM_NEW_FILE_BASENAME};

	if ( typeof closeCaptureSwf.closeWarning=="function" ){
	    warning = closeCaptureSwf.closeWarning();
	}

	if ( warning!='' ){
		return warning;
	}
	else {
		return;
	}
	    
}
