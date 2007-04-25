/* 
Capture window close events and test to see if the page has any swf's embedded with 
a "closeWarning()" callback registered to ExternalInterface.
*/
window.onbeforeunload = function()
{

	var warning='';
	var closeCaptureSwf = document.${application} || window.${application};

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
