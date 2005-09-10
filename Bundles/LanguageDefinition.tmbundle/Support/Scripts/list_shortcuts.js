function setup() {
	document.getElementById('jump').onchange = jump;
	document.getElementById('jump2').onchange = jump;
	document.getElementById('filter').onchange = filter;
	document.body.scrollTop = 0;
}

function jump() {
	window.location.hash = this.options[this.selectedIndex].value;
	document.getElementById('jump').selectedIndex = this.selectedIndex;
	document.getElementById('jump2').selectedIndex = this.selectedIndex;
}

function filter() {
	var klass = this.options[this.selectedIndex].value;
	var sheet = document.styleSheets[0];
	if (klass == "keyEquivalent" || klass == "all") {
		sheet.cssRules[0].style.cssText = "display: table-row;";
		sheet.cssRules[1].style.cssText = "display: block !important;";
	} else {
		sheet.cssRules[0].style.cssText = "display: none;";
		sheet.cssRules[1].style.cssText = "display: none;";
	}
	if (klass == "tabTrigger" || klass == "all") {
		sheet.cssRules[2].style.cssText = "display: table-row;";
		sheet.cssRules[3].style.cssText = "display: block !important;";
	} else {
		sheet.cssRules[2].style.cssText = "display: none;";
		sheet.cssRules[3].style.cssText = "display: none;";
	}
	if (klass == "trigger" || klass == "all") {
		sheet.cssRules[4].style.cssText = "display: table-row;";
		sheet.cssRules[5].style.cssText = "display: block !important;";
	} else {
		sheet.cssRules[4].style.cssText = "display: none;";
		sheet.cssRules[5].style.cssText = "display: none;";
	}
}
