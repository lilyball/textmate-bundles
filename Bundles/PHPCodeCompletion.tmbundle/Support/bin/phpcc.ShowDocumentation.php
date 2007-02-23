<?php

	#	PHPCodeCompletion .tmbundle
	#	Version: 1.0b5 - 2005-06-01
	#	Created by Mats Persson [mats@imediatec.co.uk]
	#	(C) Copyright 2005
	#	Licence: Free for anyone to use, distribute and change
	#
	#	Inspired by and partly based on phpcc by ian@ardes.com

	#	turn off all Notices in case the user have them enabled
	error_reporting(E_ALL ^ E_NOTICE);
	
	
	define( "PHPCC_PATH_ROOT", dirname( __FILE__ ) . '/' );

	#	Check if we have any arguments and deal with them
	if ( !isset( $argv[0] ) )
	{
		echo "";
	}
	else
	{
		#	OK, we have an arguement to work with
		
		#	include the PHPCC preferences settings
		include_once( 'phpcc.preferences.php' );
		
		/* */
		#	check if we have some wrong chars in there or not
		if ( !preg_match("!^[a-zA-Z0-9_]*$!", trim( $argv[1] ) ) )
		{
			#	OK, now try to extract a function name from it
			if ( preg_match( "/^([a-zA-Z0-9_]*)\s*\(/", $argv[1], $matches ) )
			{
				$function = $matches[1];				
			}
			else
			{
				#	No, couldn't work out a function name from it, so show error page
				$phpcc_is_error = TRUE;
				$function = $argv[1];
			}
		}
		else
		{
			# no we just have a plain text (so is it a function name ?)
			$function = trim( $argv[1] );
			#	set an error if it is empty so that we handle it gracefully
			$phpcc_is_error = empty( $function );			
		}
		/* */
		
		
		#	Check if we have an error first of all		
		if ( $phpcc_is_error )
		{
			#	Yes, an error has happened some where above so show error page
			$html = file_get_contents( PHPCC_PATH_ROOT . 'html/phpcc.docs.error.html' );
			#	replace some stuff inside
			$html = str_replace( "__PHPCC_SEARCH_WORD__", $function, $html );
			$html = str_replace( "__PHPCC_PREFS_FILE__", $phpcc_path_to_prefsfile, $html );
			$html = str_replace( "__PHPCC_VERSION__", $phpcc_version, $html );
			$html = str_replace( "__PHPCC_CREDIT_STRING__", $phpcc_credit_string, $html );
		}
		elseif ( !$phpcc_configured )
		{
			#	no we do not have it configured, so show start page
			$html = file_get_contents( PHPCC_PATH_ROOT . 'html/phpcc.docs.start.html' );
			$html = str_replace( "__PHPCC_PREFS_FILE__", $phpcc_path_to_prefsfile, $html );
			$html = str_replace( "__PHPCC_VERSION__", $phpcc_version, $html );
			$html = str_replace( "__PHPCC_CREDIT_STRING__", $phpcc_credit_string, $html );
		}
		else
		{
  			#	NO, no errors, so proceed
			
			#	include the lookup array based on the first character of the word
			include_once( 'lookups/phpcc.lookup.' . strtolower( $function{0} ) . '.php' );
		
			#	check if we have an exact match on that word
			if ( array_key_exists( strtolower( $function ), $_LOOKUP ) )
			{
				#	YES, so set some variables with the correct info for later
				$methodname = $_LOOKUP[$function]['methodname'];
				$docurl = $_LOOKUP[$function]['docurl'];
			}
			else
			{
				#	No not an exact match, so look for the root word
				$retVal = $function;
				$docurl = "index.html";
			}
			/* */
			
			#	load the template
			$html = file_get_contents( PHPCC_PATH_ROOT . 'html/phpcc.docs.frame.html' );
			
			#	set the active External URL 
			$ext_url = $phpcc_manual_external_url;
			$ext_url .= ( isset( $methodname ) ) ? $methodname : $retVal ;

			#	check if we have a local manual defined or not
			if ( $phpcc_manual_path_to_local !== "" )
			{
				#	OK, we have one so check if we have this file
				$local_url = ( file_exists( $phpcc_manual_path_to_local . $docurl ) ) ? "tm-file://" . $phpcc_manual_path_to_local . $docurl : FALSE;
			}
			
			#	check which manual is preferred local or external
			if ( $phpcc_manual_default_is_local )
			{
				# OK, we want a local URL, but if it don't exists then we go external
				$url = ( $local_url == FALSE ) ? $ext_url : $local_url ;
			}
			else
			{
				$url = $ext_url;
			}	
			
			#	OK, now do a check if we have external url for access to that page
			/*
				NAH, forget about it. People don't have local manual or internet access then they get nada:
			*/
			
			#	OK, finally finished with all the various configs so now output the stuff

			$html = str_replace( "__PHPCC_URL__", $url, $html );			
			$html = str_replace( "__PHPCC_PREFS_FILE__", $phpcc_path_to_prefsfile, $html );
			$html = str_replace( "__PHPCC_VERSION__", $phpcc_version, $html );
			$html = str_replace( "__PHPCC_CREDIT_STRING__", $phpcc_credit_string, $html );
		}

		#	now output the content
		echo $html;		
		
	}
	###
?>