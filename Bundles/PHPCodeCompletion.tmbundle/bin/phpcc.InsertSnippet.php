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
		echo "";
	} 
	else
	{
		#	OK, we have an argument to work with 
		#	strip of any ws around the TM_CURRENT_WORD
		$function = trim( $argv[1] );
		
		#	OK, handle some empty values
		if ( empty( $function ) )
		{
			echo "";
		}
		else
		{
			#
			/*
				TODO::	Better checking of the text coming in to see if it's already a completed function
			
			*/
			
			#	echo "function:  [ $function ]";
						
			#	include the PHPCC preferences settings
			include_once( 'phpcc.preferences.php' );			
			#	include the lookup array
			include_once( 'lookups/phpcc.lookup.' . strtolower( $function{0} ) . '.php' );

			#	check for an exact match of the function 
			if ( array_key_exists( strtolower( $function ), $_LOOKUP ) )
			{
				$snippet = $_LOOKUP[$function]['snippet'];
				#	now check which coding style version we want to have
				if ( $phpcc_snippets_use_pear )
				{
					#	using the cramped PEAR style
					$snippet = str_replace( array( "( ", " )" ), array( "(", ")" ),  $snippet );
				}
				else
				{
					#	ahh, using my wider spaced style ;)
					$snippet = str_replace( array( "(", ")", "(  ", "  )" ), array( "( ", " )", "( ", " )" ),  $snippet );
				}
				echo $snippet;
			}
			else
			{
				#	No, not an exact match, so return nothing
				echo "";
			
				/* 
				
				TODO::  Root Word Completion
				This is some stuff to try to make F1 also complet root's of words so 
				arr ->  array
				fi -> file
				and so on. It partially works, but not good enough, and sometimes it creates a php infinite loop
				which is no good.
				In other words, still work in progress :)
				
				
				#	include the functions
				include_once( 'includes/phpcc.includes.php' );
				#	No not an exact match, so look for the root word
				$resArr = mxArraySearchRegExp( $function, $_LOOKUP );
				#	echo print_r( $resArr );
				#	echo print_r( $_LOOKUP[$argv[1]] );
				$rootword = mxFindRootWord2( strlen( $function ),  $resArr );
				#	$rootword = mxFindRootWord( $function,  $resArr );
				/* * /		
				if ( $rootword != '' )
				{
					echo $rootword;
				}
				else
				{
					echo "";
				}
				/* */
			}
		}
	}

?>