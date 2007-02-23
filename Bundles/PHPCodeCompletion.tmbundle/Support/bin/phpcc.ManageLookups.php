<?php

	#	PHPCodeCompletion .tmbundle
	#	Version: 1.0b5 - 2005-06-01
	#	Created by Mats Persson [mats@imediatec.co.uk]
	#	(C) Copyright 2005
	#	Licence: Free for anyone to use, distribute and change
	#
	#	Inspired by and partly based on phpcc by ian@ardes.com

	#	turn off all Notices in case the user have them enabled
	# error_reporting(E_ALL ^ E_NOTICE);


	#	include the functions
	include_once( 'includes/phpcc.includes.php' );
	#	make sure we have the preferences
	include_once( 'phpcc.preferences.php' );

	define( "PHPCC_PATH_ROOT", dirname( __FILE__ ) . '/' );
	
	
	#	count the number of Completions we support
	$num_funcs = '3653';	#	count( $_LOOKUP );
	
	##	grab the core HTML page
	$html = file_get_contents( PHPCC_PATH_ROOT . 'html/phpcc.completions.html' );
	#	replace some stuff inside
	$html = str_replace( "__PHPCC_NUM_FUNCS__", $num_funcs, $html );
	$html = str_replace( "__PHPCC_PREFS_FILE__", $phpcc_path_to_prefsfile, $html );
	$html = str_replace( "__PHPCC_VERSION__", $phpcc_version, $html );
	$html = str_replace( "__PHPCC_CREDIT_STRING__", $phpcc_credit_string, $html );

	#	OK, we now have a basic HTML page done, with most of the stuff.
		
	/* */
		
	#
	$alpha = "a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z";
	$alphaArr = explode( ",", $alpha );
	
	#	start output buffering:
	ob_start( );
	
	#	now loop through the various bits
	foreach( $alphaArr as $key => $value )
	{
		/* */
		if ( $phpcc_completions_parse )
		{
			#	include the completions array
			include_once( 'lookups/phpcc.lookup.' . $value . '.php' );
			
			/* 
				TODO:: 
				implement solution that prints each key in the lookup and provides a direct link to the declaration
				
				probably better to make the original link in the HTML  link to 2ndary page and then only do this
				with the functions in one completions file instead of all.
				anyway, currently I can't get that to work, so thats why I'm leaving it for later
				
				#	LOVELY bit of code that will return the line number of the defined page.
				grep -n ^\"array_chunk\"  phpcc.lookup.a.php|cut -d: -f1 
			
			*/
			
			
			#	dump it out
			include( 'html/phpcc.completions.loop.parse.php' );
		}
		else
		{
			#	no, just the simple layout
			include( 'html/phpcc.completions.loop.php' );
		}
		/* */
		
	
	}
	/* */
	
	#	grab the content and stop output buffering
	$contents = ob_get_contents( );
	ob_end_clean( );
	#	ok now add it to the HTML
	$html = str_replace( "__PHPCC_COMPLETIONS_LOOP__", $contents, $html );
	
	# OK, we are done					
	echo $html;

?>