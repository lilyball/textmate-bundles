<?php

	#	PHPCodeCompletion .tmbundle
	#	Version: 1.0b1 - 2005-05-25
	#	Created by Mats Persson [mats@imediatec.co.uk]
	#	(C) Copyright 2005
	#	Licence: Free for anyone to use and distribute
	#
	#	Inspired by and partly based on phpcc by ian@ardes.com


	function mxArraySearchRegExp ( $regex, $arrHaystack )
	{
		foreach( $arrHaystack as $key => $value ){
			if ( ereg( "^".$regex, $key ) ){
				$retVal[] = $key;
			}
		}
		return ( is_array( $retVal ) ) ? $retVal : FALSE;
	}
	###

	function mxArraySearchRegExpValue ( $regex, $arrHaystack )
	{
		foreach( $arrHaystack as $key => $value ){
			if ( ereg( "^".$regex, $value ) ){
				$retVal[] = $value;
			}
		}
		return ( is_array( $retVal ) ) ? $retVal : FALSE;
	}
	###
	
	#	Function partly taken from the original phpcc by ian@ardes.com
	function mxFindRootWord2 ( $InPos, $Possibles )
	{
		$pos = $InPos;
		do {
			$letters = array();
			foreach( array_keys( $Possibles ) as $key )
			{
				$letters[$Possibles[$key]{$pos}] = true;
			}
			$pos++;
		} while ( count( $letters ) == 1 );
		
		return substr( $Possibles[0], $InPos, $pos - 1 );
	}
	###
	
	function mxFindRootWord ( $WordIn, $Possibles )
	{
		$startpos = strlen( $WordIn );
		do {
			$letters = array();
			foreach( array_keys( $Possibles ) as $key )
			{
				$letters[$Possibles[$key]{$pos}] = true;
			}
			$pos++;
		} while ( count( $letters ) == 1 );

		$retVal = substr( $Possibles[0], 0, $pos - 1 );
		return str_replace ( $WordIn, '', $retVal );		
	}
	###

?>