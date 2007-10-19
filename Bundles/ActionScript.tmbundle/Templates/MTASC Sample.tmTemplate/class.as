//
//  ${TM_NEW_FILE_BASENAME}
//
//  Created by ${TM_FULLNAME} on ${TM_DATE}.
//  Copyright (c) ${TM_YEAR} ${TM_ORGANIZATION_NAME}. All rights reserved.
//
// A *really* crude sample to test the "Build in MTASC" command
// Run the "Install MTASC Support Files" in your project before running "Build in MTASC", and be sure to edit the data to suit your class' name
//

class ${TM_NEW_FILE_BASENAME} {
	function ${TM_NEW_FILE_BASENAME}() {
		// Empty constructor
	}
	// Hook for MTASC. This method will be called to start the application
	static function main() {
		_root.createTextField("hello_txt",1,0,0,800,30);
		_root.hello_txt.text = "Hello, World!";
	}
};