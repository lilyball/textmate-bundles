<html>
	<head>
		<!-- copyright Max Williams 2005 -->
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
			a:hover, .selected{
				color:red;
				border-color:grey;
				}
		</style>
		<script type='text/javascript'>
			
			var inc=-1;
			var prev=0;
			
			function key(evt) {
				var charCode=evt.keyCode;
				prev=inc;            
				if (charCode == 40 ){
					if (inc<listMax)
						inc++;	
				}
				else if (charCode == 38){
					if (inc>0)
						inc--;
				}
				else if (charCode == 13){
					lineOpen();
				}
				move();
			}
			
			function move(){
				if (prev>-1){
					var oldTarget=document.getElementById(prev);
					oldTarget.className="";
				}
				var target=document.getElementById(inc);
				target.className="selected";
			}
			
			function lineOpen(){
				var target=document.getElementById(inc);
				var myName=target.firstChild.nodeValue;
				var myLink=target.href;			
				top.location.replace(myLink)
			}
			
		</script>
	</head>
	<body onkeydown="key(event)">
		<h1>Entities for <?php echo $_ENV['TM_FILENAME']; ?></h1>	
		<ul id='list'>
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
		<script type='text/javascript'>
			var list= document.getElementsByTagName("PRE");
			var listMax = list.length-1;
		</script>
	</body>
</html>
