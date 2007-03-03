<!-- BEGIN LOOP CODE -->
<div id="div_<?php echo $value; ?>">
	
	<h3 class="divTitle"><?php echo strtoupper( $value ); ?></h3>
	<p>
		&nbsp; [ <a href="txmt://open?url=file://<?php echo PHPCC_PATH_ROOT ?>lookups/phpcc.lookup.<?php echo $value; ?>.php" class="editLink">
				Edit Completions </a> ] 
		&nbsp; &nbsp; | &nbsp; &nbsp; [ List Completions ] 
		&nbsp; &nbsp; | &nbsp; &nbsp; [ Debug Completion Output ] 
	</p>
</div>
<hr />
<!-- END LOOP CODE -->
