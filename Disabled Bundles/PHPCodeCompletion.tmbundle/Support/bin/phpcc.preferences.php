<?php

	#	PHPCodeCompletion::  1.0b5  2005-06-06
	
	
	###	USER PREFERENCES::
	
	
	###	Begin PHPCC_CONFIGURED Setting::
	##	To enable the PHPCC Documentation just swap FALSE to TRUE below

	$phpcc_configured = FALSE ;	#	default value
	# $phpcc_configured = TRUE;
	
	###	End PHPCC_CONFIGURED Setting::
	


	###	Begin PHPCC_MANUAL_DEFAULT_IS_LOCAL Setting::
	##	Sets whether if we should default to a local or external manual.
	##	Default is that it looks for a local file first and if found loads it, else goes to external page.
	##	IF you want the External manual then set this to false (if you have defined the local manual below)
	
	$phpcc_manual_default_is_local = TRUE;	#	default value 
	#	$phpcc_manual_default_is_local = FALSE;

	###	End PHPCC_MANUAL_DEFAULT_IS_LOCAL Setting::



	###	Begin PHPCC_MANUAL_PATH_TO_LOCAL Setting::
	##	Set the path to where your local php_manual_en directory is. 
	##	If you do not wish to have a local manual just leave it empty

	#	$phpcc_manual_path_to_local = "";   #	default value
	
	###	End PHPCC_MANUAL_PATH_TO_LOCAL Setting::


	
	###	Begin PHPCC_MANUAL_EXTERNAL_URL Setting::
	##	Set the URL to where to load the PHP manual from. Default is the main PHP.net website [ http://www.php.net/]
	##	PLEASE NOTE !:  Leave it empty and PHPCC Documentation WILL NOT WORK !!
		
	$phpcc_manual_external_url =  "http://www.php.net/";	#	default value

	###	End PHPCC_MANUAL_EXTERNAL_URL Setting::
	
	
	
	###	Begin PHPCC_SNIPPETS_USE_PEAR Setting::
	##	Controls the output formatting of the snippets, ie: whitespace after ( and before )
	##	TRUE	=	array_slice($array, $offset)
	##	FALSE	=	array_slice( $array, $offset )
	
	$phpcc_snippets_use_pear = TRUE;	#default value
	#	$phpcc_snippets_use_pear = FALSE;	
	###	End PHPCC_SNIPPETS_USE_PEAR Setting::


	
	###	Begin PHPCC_COMPLETIONS_PARSE Setting::
	##	Set this preference to output all the completions arrays into the HTML window when managing completions.
	##	Takes a longer time and might not be needed so is disabled by default. Just change FALSE to TRUE
	
	$phpcc_completions_parse = FALSE;	#	default value
	#	$phpcc_completions_parse = TRUE;
	
	###	End PHPCC_COMPLETIONS_PARSE Setting::




	###	END USER PREFERENCES::  ===================================================
	###	PLEASE DO NOT EDIT BELOW THIS LINE UNLESS YOU KNOW WHAT YOU ARE DOING	###
	#==============================================================================
			
	#	set PHPCC version
	$phpcc_version = "1.0b5";	#	default value
	#

	#	set the full path to the preferences file
	$phpcc_path_to_prefsfile = 	dirname( __FILE__ ) . '/phpcc.preferences.php';

	###	Begin PHPCC_TOOLTIP_* Setting::
	##	Set the width of descriptions in PHPCC tooltips 

	$phpcc_tooltip_desc_wrapwidth  = 100;	#	default value

	/* TODO:: ?? Should we even make this configurable ? * /
		$phpcc_tooltip_config = array (
			"line1" => "",
			"line2" => "",
			"line3" => "",
			"line4" => ""
			);

	*/
	
	##	Footer Credit String::
	$phpcc_credit_string = "created by Mats Persson [ mats@imediatec.co.uk ] inspired by Ian Ardes' original phpcc";


?>