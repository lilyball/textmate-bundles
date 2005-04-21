<html>
	<head>
		<style type= "text/css">
			* {
				font-family:"Lucida Grande";
				margin:0px;
				padding:0px;	
			}
			h1 {
				font-size:.9em;
				}
			h1, p{
				padding-left:3px;
				}
			p, a {	
				color:grey;
				font-size: 0.8em;
			}
			ul{
				list-style:none;
				padding-left:5px;
				}
			a{
				display:block;
				text-decoration:none;
				border:1px white solid;
				white-space: pre;
				}
			a:hover, .selected, a:focus {
				color:red;
				border-color:grey;
				}
		</style>
		<script type="text/javascript">
		
		    function attachSelectedEvent()
		    {
		        anchors = document.getElementsByTagName('a');
		        for (i=0; i<anchors.length; i++) {
		            if (anchors[i].onclick) {
		                anchors[i].postOnClick = anchors[i].onclick;
		            }
		            anchors[i].onclick = selectLink;
		        }
		    }
		    
		    function selectLink()
		    {
		        this.className = "selected";
		        if (this.postOnClick) {
		            return this.postOnClick();
		        } else {
		            return true;
		        }
		    }
		
		    function postLoadInit()
		    {
		        setf();
		        attachSelectedEvent();
		    }

			function setf() 
			{
			    var focusAnchor = document.getElementById('line_' + "<?php echo getenv('TM_LINE_NUMBER'); ?>");
			    if (!focusAnchor) {
			        var anchors	= document.getElementsByTagName('a');
			        focusAnchor = anchors[0];    
			    }
				focusAnchor.focus();
			}
			
			window.onload=postLoadInit;
		</script>
	</head>
	<body>
		<h1>Entities for <?php echo getenv('TM_FILENAME'); ?>:</h1>	
		<p> (option-tab to move down, shift-option-tab to move up) </p>
		<br />
		<ul id="list">
<?php
	while ( ($line = fgets(STDIN)) !== false ) {
	    
	    if ( ($token = strpos($line, ':')) === false) {
	        $lineNum = 0;
	    } else {
	        $lineNum = substr($line, 0, $token);
	        $line = substr($line, $token + 1);
	    }
	    
	    // a little hack to accept a keep-open argument (this will all be moved to python soon, I promise)
	    $extra_tag_params = '';
	    if (!in_array('--keep-open', (array)$_SERVER['argv'])) {
	        $extra_tag_params .= 'onclick="javascript:window.close()"';
	    }
	    
	    echo implode('', array(
	        "\t\t\t<li> <a id=\"line_{$lineNum}\" href=\"txmt://open?url=file://", getenv('TM_FILEPATH'), "&amp;line={$lineNum}\" {$extra_tag_params}>", 
	        $line, "</a></li>\n"));
	}
?>
		</ul>
	</body>
</html>

