<html>
	<head>
		<style type='text/css'>
			pre, h1{
				font-family:"Lucida Grande";
				font-size:.9em;
				margin:0px;
				padding:0px;
				}
			ul{
				list-style:none;
				padding-left:5px;
				}
			li{
			}
			a{
				color:grey;
				display:block;
				text-decoration:none;
				border:1px white solid;
				}
			a:hover{
				color:red;
				border-color:grey;
				}
		</style>
	</head>
	<body>
		<h1>Entities for <?php echo $_ENV['TM_FILENAME']; ?></h1>	
		<ul>
<?php
	if ($_SERVER['argv'][1]=="c")
		$close="onclick='window.close()'";
	else 
		$close="";
	$stdin = fopen('php://stdin', 'r');
	$split = explode("\n", fread($stdin,1024*1024));
	foreach( $split as $key => $value )
	{
		$tmp= explode(":", $value);
		echo "\t\t\t<li> <a href='txmt://open?url=file://".$_ENV['TM_FILEPATH']."&amp;line=".$tmp[0]."' ".$close."> <pre>". $tmp[1]."</pre></a></li>";
	}
?>
		</ul>
	</body>
</html>
