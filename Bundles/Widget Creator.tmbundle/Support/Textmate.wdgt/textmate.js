//Use the default values for the internal variables.
var widgetLabel = "Untitled";
//What to call the script when passed from Textmate.
var textmateScript = "New Script From Textmate";
//The variable used to control the script.
var command;
//Define where to keep the logs and what to call them
var logfolder = "logs/" + widget.identifier + "/";
var outputlog = "stdout.log";
var errorlog = "stderr.log";
//Define where we want to keep the scripts, the uri is used by a txmt:// call to open in textmate.
var scriptfolder = "Library/Application Support/Textmate/Widget Scripts/";
//Define what to call our script file.
var scriptfile;
//Define our timer.
var timer;
//Record if we are running or not.
var running = false;
//The delay in milliseconds before showing the stop icon.
var delay = 200;
//The default colour;
var labelcolour = "Blue";

function init() {
	//Make sure our widget calls a function to clean up after being removed.
	widget.onremove = onremove;
	//Create and "info" button to flip the widget over.
	new AppleInfoButton(document.getElementById("infoButton"), document.getElementById("front"), "white", "white", showPrefs);
	//Create a button on the back of the widget to save the settings and flip back over.
	new AppleGlassButton(document.getElementById("doneButton"), "Done", done);
	//Create a button so that we can edit the script used by the widget.
	new AppleGlassButton(document.getElementById("TMButton"), "Edit", edit);
	//Attempt to load our saved preferences for the widget.
	loadPrefs();
	//Check whether a script has been sent by the widget bundle.
	bundleCheck();
	//make the script if necessary.
	makeScript();
}

function getUserPath(filename) {
	//Return a pathname for the user area of OS X.
	return "~/\"" + escapeFilename(filename) + "\"";
}

function makeScript() {
	var escapedFile = getUserPath(scriptfolder + scriptfile);
	//Create the support folder if necessary.
	widget.system("mkdir -p " + getUserPath(scriptfolder), null);
	//If our script does not exist...
	if (!fileExist(escapedFile)) {
		//...then create it...
		widget.system("echo \\#\\!\\/usr/bin/env bash > " + escapedFile, null);
		//...and make it executable...
		widget.system("chmod +x " + escapedFile, null);
		savePrefs();
	}
}

function bundleCheck() {
	var escapedFile = getUserPath(scriptfolder + scriptfile);
	//Create the support folder if necessary.
	widget.system("mkdir -p " + getUserPath(scriptfolder), null);
	//If a shell script created by the bundle exists.
	if (fileExist(getUserPath(scriptfolder + "default.sh"))) {
		//If our script does not exist...
		if (!fileExist(escapedFile)) {
			scriptfile = getAvailableFile(textmateScript) + ".sh";
			escapedFile = getUserPath(scriptfolder + scriptfile);
			//... then use the one created by the bundle...
			widget.system("mv " + getUserPath(scriptfolder) + "default.sh " + escapedFile, null);
			//... and make it executable...
			widget.system("chmod +x " + escapedFile, null);
			//If Textmate has given us a filename to use...
			if (fileExist(getUserPath(scriptfolder + "filename.txt"))) {
				//Get the filename stored in the file.
				var output = widget.system("paste -s " + getUserPath(scriptfolder + "filename.txt"), null).outputString.substr(0, 32);
				//... use it for the widget... document.getElementById("scriptName").value.
				document.getElementById("scriptName").value = output;
				//Remove the temporary file.
				widget.system("rm " + getUserPath(scriptfolder + "filename.txt"), null);
				//Rename the file to something suitable.
				renamefile(output);
			} else {
				//... otherwise use a default name.
				document.getElementById("scriptName").value = textmateScript;
			}
			//Save the changes...
			savePrefs();
			//... and show the prefs so that we can change the default name.
			showPrefs();
		}
	}
}

function loadPrefs() {
	//Attempt to load the prefences and store in a temporary variable.
	var widgetLabelTemp = widget.preferenceForKey(createKey("Widget Label"));
	var labelcolourTemp = widget.preferenceForKey(createKey("Label Color"));
	var scriptfileTemp = widget.preferenceForKey(createKey("Widget Script"));
	//If there is already a saved value, use it for the widget.
	if (widgetLabelTemp) widgetLabel = widgetLabelTemp;
	if (labelcolourTemp) labelcolour = labelcolourTemp;
	if (scriptfileTemp) {
		scriptfile = scriptfileTemp;
	} else {
		scriptfile = getAvailableFile(widgetLabel) + ".sh";
	}
	//Update the textbox to the value used by the widget.
	document.getElementById("scriptName").value = widgetLabel;
	//Update the label.
	clickSwatch(labelcolour);
	updateLabel(widgetLabel);
}

function savePrefs() {
	//Get the value of the text box.
	widgetLabel = document.getElementById("scriptName").value;
	//Update the label.
	updateLabel(widgetLabel);
	//Save it to preferences.
	widget.setPreferenceForKey(widgetLabel, createKey("Widget Label"));
	widget.setPreferenceForKey(labelcolour, createKey("Label Color"));
	widget.setPreferenceForKey(scriptfile, createKey("Widget Script"));
}

function updateLabel(text) {
	//Escape the text for HTML.
	text = escapeHTML(text);
	//Update the label(s).
	document.getElementById("scriptNameLabel_Red").innerHTML = text;
	document.getElementById("scriptNameLabel_Orange").innerHTML = text;
	document.getElementById("scriptNameLabel_Yellow").innerHTML = text;
	document.getElementById("scriptNameLabel_Green").innerHTML = text;
	document.getElementById("scriptNameLabel_Blue").innerHTML = text;
	document.getElementById("scriptNameLabel_Purple").innerHTML = text;
	document.getElementById("scriptNameLabel_Gray").innerHTML = text;
	document.getElementById("scriptNameShadow").innerHTML = text;
	document.getElementById("iconNameLabel").innerHTML = text;
}

function escapeHTML(text) {
  var div = document.createElement('div');
  var text = document.createTextNode(text);
  div.appendChild(text);
  return div.innerHTML;
}

function click() {
	//Start the script with no parameters.
	startScript("");
}

function edit() {
	//Open our shell script with Textmate.
	widget.openURL("txmt://open?url=file://" + encodeURIComponent("~/" + scriptfolder + scriptfile));
}

function showPrefs() {
	//Flip the widget over.
	flip(document.getElementById("front"), document.getElementById("back"), "ToBack");
	//Add a keyboard listener so we can detect the when the enter key is being used.
	document.addEventListener("keydown", keyPressed, true);
}

function keyPressed (event) {
	//Get the key which was pressed.
	var key = event.charCode;
	//If it was the enter or return, then click on complete the preferences.
	if (key == 13 || key ==3) done();
	return;
}


function done() {
	var widgetLabelTemp = document.getElementById("scriptName").value;
	//Make sure we actually have a value to work with.
	if (widgetLabelTemp != "") {
		//If the user has changed the label of the widget.
		if (widgetLabelTemp != widgetLabel) {
			//Change the filename to something suitable.
			renamefile(widgetLabelTemp);
		}
		//... remove the keyboard listener as its no longer required...
		document.addEventListener("keydown", keyPressed, true);
		//Save the preferences...
		savePrefs();
		//... and flip the widget back over.
		flip(document.getElementById("back"), document.getElementById("front"), "ToFront");
	}
}

function renamefile(filename) {
	//Get a filename which is available.
	filename = getAvailableFile(filename) + ".sh";
	//Rename our file.
	widget.system("mv " + getUserPath(scriptfolder + scriptfile) + " " + getUserPath(scriptfolder + filename), null);
	//Update our global var.
	scriptfile = filename;
}

function getAvailableFile(filename) {
	filename = filename.replace(/\//g, ":");
	//Get a version of the filename a shell command will like.
	var filenameTemp = escapeFilename(filename);
	//If our filename is available;
	if (!fileExist(getUserPath(scriptfolder + filenameTemp + ".sh"))) {
		//Give back the original filename.
		return filename;
	}
	//Otherwise add a numeric at the end starting with "2".
	var count = 1;
	do {
		count++;
		//Keep testing the availability of the file.
	} while (fileExist(getUserPath(scriptfolder + filenameTemp + " " + count + ".sh")))
	//Return our new filename.
	return filename + " " + count;
}

function escapeFilename(text) {
	//Escape our filename so it doesn't cause any problems.
	return text.replace(/\"/g, "\\\"").replace(/`/g, "\\`");
}

function fileExist(filename) {
	//Call a command to see if the file exists.
	var output = widget.system("ls " + filename + " > /dev/null; echo $?", null).outputString;
	//If so return true...
	if (output == 0) return true;
	//...otherwise return false.
	return false;
}

function onremove() {
	//If we remove the widget, remove the preferences for that widget.
	widget.setPreferenceForKey(null, createKey("Widget Label"));
	widget.setPreferenceForKey(null, createKey("Widget Script"));
	widget.setPreferenceForKey(null, createKey("Label Color"));
	//Delete our script.
	widget.system("rm " + getUserPath(scriptfolder + scriptfile), null);
	//Delete the log folder...
	widget.system("rm -R \"" + logfolder + "\"", null);
}

function createKey(name) {
	//Return a unique ID for prefs based on the unique ID of the widget.
	return widget.identifier + "." + name;
}

function flip(front, back, transition) {
	//Prepare the widget for the flip...
	if (window.widget) widget.prepareForTransition(transition);
	//... hide the frontmost layer...
	front.style.display="none";
	//... show the hidden layer...
	back.style.display="block";
	//... and do the transition.
	if (window.widget) setTimeout ("widget.performTransition();", 0);
}

function dragdrop(event) {
	//Turn the Textmate icon back to its normal colour.
	document.getElementById("imgTextmate").src = "images/Icon/textmate_icon.png";

	//Define dropfile, the variable used to store the info from the drag & drop operation.
	var dropfile = null;
	//Attempt to get the data from the drag & drop.
	try {
		//Get the text from the drag & drop.
		dropfile = event.dataTransfer.getData("text/uri-list");
	} catch (ex) {
		//If an error is caught then display a message.
		writeDebug("error caught");
	}
	//If there is any data.
	if (dropfile)
	{
		var params = "";
		//If we are dealing with a bunch of files.
		if (dropfile.substr(0,5) == "file:") {
			//Create a new array element for each file.
			var dropfiles = dropfile.split("\n");
			for (loop = 0; loop < dropfiles.length; loop++) {
				//Parse the URI for each element, recording it in params seperated by a space.
				params = params + "\"" + escapeFilename(decodeURIComponent(dropfiles[loop].replace(/file:\/\/(.*?)\//g, "/"))) + "\" ";
			}
			//Call the script.
			startScript(params);
		} else {
			//Escape the URL properly and call the script.
			startScript("\"" + dropfile + "\"");
		}
	}
	//Do usual drap & drop stuff.
	event.stopPropagation();
	event.preventDefault();
}

function startScript(params) {
	var escapedFile = getUserPath(scriptfolder + scriptfile);
	//If our script does exist then call it.
	if (fileExist(escapedFile)) {
		//Start our timer.
		timer = setTimeout("showStopIcon();", delay);
		//Show we are running.
		running = true;
		//Start the script.
		command = widget.system(escapedFile + " " + params, scriptDone);
		//Hide the stars.
		hideStars();
		//Start logging.
		beginLogging();
	}
}

function showStopIcon() {
	if (running) {
		//Hide the Textmate icon...
		imgTextmate.style.display = "none";
		CatchArea.style.display = "none";
		infoButton.style.display = "none";
		//... and show the stop button.
		StopIcon.style.display = "block";
	}
}

function beginLogging() {
	//Delete the error log...
	widget.system("rm -R \"" + logfolder + "\"", null);
	//Recreate the folder
	widget.system("mkdir -p \"" + logfolder + "\"", null);
	//Make sure we report the errors...
	command.onreaderror = readerror;
	//... as well as the output.
	command.onreadoutput = readoutput;
}

function redStar() {
	//Open the error log.
	widget.system("open \"" + logfolder + errorlog + "\"" , null);
	//Hide the star.
	document.getElementById("redStar").style.display = "none";
}

function greenStar() {
	//Open the output log.
	widget.system("open \"" + logfolder + outputlog + "\"" , null);
	//Hide the star.
	document.getElementById("greenStar").style.display = "none";
}

function hideStars() {
	//Hide both the stars.
	document.getElementById("redStar").style.display = "none";
	document.getElementById("greenStar").style.display = "none";
}

function readerror(text) {
	//Append the error text to the error log file.
	widget.system("echo -n \"" + text.replace(/\"/g, "\\\"") + "\" >> \"" + logfolder + errorlog + "\"", null);
	//Give visual feedback that the script has returned an error.
	document.getElementById("redStar").style.display = "block";
}

function readoutput(text) {
	//Append the output text to the output log file.
	widget.system("echo -n \"" + text.replace(/\"/g, "\\\"") + "\" >> \""  + logfolder + outputlog + "\"", null);
	//Give visual feedback that the script has returned output.
	document.getElementById("greenStar").style.display = "block";
}

function dragenter(event) {
	//Turn the Textmate icon to green.
	document.getElementById("imgTextmate").src = "images/Icon/textmate_glow.png";
	//Handle drag & drop event stuff.
	event.stopPropagation();
	event.preventDefault();
}

function dragover(event) {
	//Handle drag & drop event stuff.
	event.stopPropagation();
	event.preventDefault();
}

function dragleave(event) {
	//Turn the Textmate icon back to its normal colour.
	document.getElementById("imgTextmate").src = "images/Icon/textmate_icon.png";
	//Handle drag & drop event stuff.
	event.stopPropagation();
	event.preventDefault();
}

function writeDebug(text) {
	//Write a message to the widget for debug purposes.
	document.getElementById("debug").innerHTML = text;
}

function stopClick() {
	//Stop the script.
	command.cancel();
	//Restore the widget back to normal.
	scriptDone();
}

function scriptDone(command) {
	//Show the Textmate icon again.
	imgTextmate.style.display = "block";
	CatchArea.style.display = "block";
	//Hide the stop button.
	StopIcon.style.display = "none";
	infoButton.style.display = "block";
	//Show we are no longer running.
	running = false;
}

function clickSwatch(text) {
	document.getElementById(labelcolour+"_tick").style.display = "none";
	document.getElementById("NameTable_" + labelcolour).style.display = "none";
	labelcolour=text;
	document.getElementById(labelcolour+"_tick").style.display = "block";
	document.getElementById("NameTable_" + labelcolour).style.display = "block";
}