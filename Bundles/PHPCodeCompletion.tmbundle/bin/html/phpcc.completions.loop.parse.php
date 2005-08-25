<!-- BEGIN LOOP CODE -->
<div id="div_<?php echo $value; ?>">
	<p class="divTitle">
		<strong><?php echo strtoupper( $value ); ?></strong> 
		&nbsp; &nbsp; <a href="javascript:scrollTop();" title="Scroll to top of page">&laquo;&laquo; Go To Top</a> 
		<span class="floatRight">
		 	[ <a href="txmt://open?url=file://<?php echo PHPCC_PATH_ROOT ?>lookups/phpcc.lookup.<?php echo $value; ?>.php" class="editLink">
				Edit the Completions in this section
			</a> ]
		</span>
	</p>
	<div class="infoContainer">
		<p>[ <a id="pre_<?php echo $value; ?>_toggle" href="javascript:toggleObject('pre_<?php echo $value; ?>');">View these Completions</a> ]</p>
		<div id="pre_<?php echo $value; ?>" class="hidden">
			<pre><?php 
				echo print_r( $_LOOKUP, 1 );
				?>
			</pre>

			<p>
			 &nbsp; &nbsp; <a href="javascript:scrollTop();" title="Scroll to top of page">&laquo;&laquo; Go To Top</a>
			 &nbsp; | &nbsp; [ <a href="javascript:toggleObject('pre_<?php echo $value; ?>');">Hide these Completions</a> ]
			 &nbsp; | &nbsp; [ <a href="txmt://open?url=file://<?php echo PHPCC_PATH_ROOT ?>lookups/phpcc.lookup.<?php echo $value; ?>.php" class="editLink">Edit the Completions in this section</a> ]
			</p>
		</div>
	</div>
</div>
<hr />
<!-- END LOOP CODE -->
