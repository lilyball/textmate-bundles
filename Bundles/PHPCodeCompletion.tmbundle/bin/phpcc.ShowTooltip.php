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
	
	
	
	#	Check if we have any arguments and deal with them
	if ( !isset( $argv[0] ) )
	{
		echo "This function only works when you have the caret on a word or to the immediate left of a word";
	} 
	else
	{
		#	OK, we have an argument to work with so check for an exact match of the word first to prevent matching wrong words
		
		/* */
		#	check if we have some wrong chars in there or not
		if ( !preg_match("!^[a-zA-Z0-9_]*$!", trim( $argv[1] ) ) )
		{
			#	OK, now try to extract a function name from it
			if ( preg_match( "/^([a-zA-Z0-9_]*)\s*\(/", $argv[1], $matches ) )
			{
				#	$html = "function = [" . print_r( $matches, 1 ) . "]";
				$function = $matches[1];				
			}
			else
			{
				echo "ERROR:: Invalid characters in the checked word: [ $argv[1] ]\n";
				echo "Please Note! This command only works with the caret inside or \n";
				echo "immediately after a real PHP function/keyword such as 'php_info' \n";
				echo "and not on non-functions or with the caret inside the ( ) of a function.\n";
				echo "Alternatively, you can also select the whole function that you are looking for info on.";
				exit();
			}
		}
		else
		{
			# no we just have a plain text (function name ?)
			$function = trim( $argv[1] );
		}
		/* */

		#	OK, handle some empty values
		if ( empty( $function ) )
		{
			echo "ERROR:: We cannot do a tooltip on a value that is empty: [ $function ]\n";
		}
		else
		{

			#	include the functions
			include_once( 'includes/phpcc.includes.php' );
			#	include the PHPCC preferences settings
			include_once( 'phpcc.preferences.php' );

			#	include the big array
			include_once( 'lookups/phpcc.lookup.' . strtolower( $function{0} ) . '.php' );


			if ( array_key_exists( strtolower( $function ), $_LOOKUP ) )
			{
				echo "Syntax:  " . $_LOOKUP[$function]['method'];
				echo "\nDesc:    " . wordwrap( $_LOOKUP[$function]['desc'], $phpcc_tooltip_desc_wrapwidth, "\n         " ) ;
				echo "\nVersion: " . $_LOOKUP[$function]['version']; 
				#	echo "\nTM PHP Version:  " . phpversion()  ;			
			}
			else
			{
				#	No not an exact match, so look for the root word
				$resArr = mxArraySearchRegExp( $function, $_LOOKUP );
				if ( $resArr === FALSE )
				{
					echo "[ $function ] was not recognised as a declared PHPCC completion.\n";
					echo "PHPCC currently only supports known PHP functions and some PHP keywords.\nYou can easily add a completion for this word by using the \"Manage Completions\" command.";
				}
				else
				{
					echo "Similar Functions:\n" . implode( "\n", $resArr );
				}
			}

		}
		
	}
	###

?>