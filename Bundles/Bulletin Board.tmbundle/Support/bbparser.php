<?php
/*
These functions are taken from cbparser.php
the corzblog bbcode to x|html and back to bbcode parser

converts bbcode to html and back to bbcode, and does it quickly. a bit
clunky, but it gets the job done each and every day. output is 100% valid
xhtml 1.0 strict. we use css to style the output as desired, your call.

feel free to use this code for your own projects, I designed it with
this in mind; linear. leave a "corz.org" lying around somewhere.
a link to my site is always cool.
*/

/*
function bb2html($bb2html, $title)
*/
function bb2html() {
global $cb_ref_title, $smilie_folder, $insert_link, $effin_casinos, $prevent_xss, $spammer_strings;
$args = func_num_args(); 
$bb2html = func_get_arg(0);
if ($args == 2) {
	$title = func_get_arg(1);
	$id_title = make_valid_id($title); // fix up bad id's
} else { $id_title = $title = '';}

	// oops!
	if ($bb2html == '') return false;

	/*
		special code formatting

		because this happens first, it's not possible do to [[pre]] or [[ccc]] in your bbcode,
		(for demo purposes) (though technically, you could put [[ccc]]code[[/ccc]] inside [pre] tags)
		pre-formatted text (even bbcode inside [pre] text will remain untouched, as it should be)

		there may be multiple [pre] or [ccc] blocks, so we grab them all and create arrays..
		*/

	$pre = array(); $i = 0;
	while ($pre_str = stristr($bb2html, '[pre]')) {
		$pre_str = substr($pre_str, 0, strpos($pre_str, '[/pre]') + 6);
		$bb2html = str_replace($pre_str, "***pre_string***$i", $bb2html);
		// we encode this, for html tags, etc..
		$pre[$i] = encode($pre_str);
		$i++;
	}

	/*
		syntax highlighting (Cool Colored Code™)
		och, why not!
		*/
	$ccc = array(); $i = 0;
	while ($ccc_str = stristr($bb2html, '[ccc]')) {
		$ccc_str = substr($ccc_str, 0, strpos($ccc_str, '[/ccc]') + 6);
		$bb2html = str_replace($ccc_str, "***ccc_string***$i", $bb2html);
		$ccc[$i] = str_replace("\r\n", "\n", $ccc_str);
		$i++;
	}

/*
	rudimentary tag balance checking..
	this works really well!
	*/
	//$removers = array("/\[\[(.*)\]\]/i","/\<hr (.*) \/\>/"); 
	$check_string = preg_replace("/\[\[(.*)\]\]/i","",$bb2html); // add tags that don't need closed..
	$removers = array('[[',']]','[hr]','[hr2]','[hr3]','[hr4]','[sp]','[*]','[/*]');
	$check_string = str_replace($removers, '', $check_string);
	// simple counting..
	if ( ((substr_count($check_string, "[")) != (substr_count($check_string, "]")))
	or  ((substr_count($check_string, "[/")) != ((substr_count($check_string, "[")) / 2))
	
	// a couple of common errors (I might get around to an array for this)
	// but these two are definitely the main culprits for tag mixing errors..
	or  (substr_count($check_string, "[b]")) != (substr_count($check_string, "[/b]"))
	or  (substr_count($check_string, "[i]")) != (substr_count($check_string, "[/i]")) ) {
		return false;
	}

	$bb2html = str_replace('<', '***lt***', $bb2html);
	$bb2html = str_replace('>', '***gt***', $bb2html);


	// xss attack prevention [99.9% safe!]..
	if ($prevent_xss) { $bb2html = xssclean($bb2html); }


	// oh dem pesky casinos...
	if ($effin_casinos == true) {
		if (stristr($bb2html, 'casino')) {
			$bb2html = preg_replace("/\[url(.*)\](.*)\[\/url\]/i",
			"[url=\"http://$insert_link\" title=\"hahahah\!\"]\$2[/url]", $bb2html);
		}
	}


	// now the bbcode proper..

	// grab any *real* square brackets first, store 'em
	$bb2html = str_replace('[[[', '**$@$**[', $bb2html); // catch tags next to demo tags
	$bb2html = str_replace(']]]', ']**@^@**', $bb2html); // ditto
	$bb2html = str_replace('[[', '**$@$**', $bb2html);
	$bb2html = str_replace(']]', '**@^@**', $bb2html);

	// news headline block
	$bb2html = str_replace('[news]', '<div class="cb-news">', $bb2html);
	$bb2html = str_replace('[/news]', '<!--news--></div>', $bb2html);

	// references - we need to create the whole string first, for the str_replace
	$r1 = '<a class="cb-refs-title" href="#refs-'.$id_title.'" title="'.$cb_ref_title.'">';
	$bb2html = str_replace('[ref]', $r1 , $bb2html);
	$bb2html = str_replace('[/ref]', '<!--ref--></a>', $bb2html);
	$ref_start = '<div class="cb-ref" id="refs-'.$id_title.'">
<a class="ref-title" title="back to the text" href="javascript:history.go(-1)">references:</a>
<div class="reftext">';
	$bb2html = str_replace('[reftxt]', $ref_start , $bb2html);
	$bb2html = str_replace('[/reftxt]', '<!--reftxt-->
</div>
</div>', $bb2html);

	// ordinary transformations..
	$bb2html = str_replace('&', '&amp;', $bb2html);

	// we rely on the browser producing \r\n (DOS) carriage returns, as per spec.
	$bb2html = str_replace("\r",'<br />', $bb2html);	// the \n remains, and makes the raw html readable
	$bb2html = str_replace('[b]', '<strong>', $bb2html); //ie. "\r\n" becomes "<br />\n"
	$bb2html = str_replace('[/b]', '</strong>', $bb2html);
	$bb2html = str_replace('[i]', '<em>', $bb2html);
	$bb2html = str_replace('[/i]', '</em>', $bb2html);
	$bb2html = str_replace('[u]', '<span class="underline">', $bb2html);
	$bb2html = str_replace('[/u]', '<!--u--></span>', $bb2html);
	$bb2html = str_replace('[big]', '<big>', $bb2html);
	$bb2html = str_replace('[/big]', '</big>', $bb2html);
	$bb2html = str_replace('[sm]', '<small>', $bb2html);
	$bb2html = str_replace('[/sm]', '</small>', $bb2html);

	// tables (couldn't resist this, too handy) hmm.. will we do these in css now? //:2do:
	$bb2html = str_replace('[t]', '<div class="cb-table">', $bb2html);
	$bb2html = str_replace('[bt]', '<div class="cb-table-b">', $bb2html);
	$bb2html = str_replace('[st]', '<div class="cb-table-s">', $bb2html);
	$bb2html = str_replace('[/t]', '<!--table--></div><div class="clear"></div>', $bb2html);
	$bb2html = str_replace('[c]', '<div class="cell">', $bb2html);	// regular 50% width
	$bb2html = str_replace('[c1]', '<div class="cell1">', $bb2html);	// cell data 100% width
	$bb2html = str_replace('[c3]', '<div class="cell3">', $bb2html);
	$bb2html = str_replace('[c4]', '<div class="cell4">', $bb2html);
	$bb2html = str_replace('[c5]', '<div class="cell5">', $bb2html);
	$bb2html = str_replace('[/c]', '<!--end-cell--></div>', $bb2html);
	$bb2html = str_replace('[r]', '<div class="cb-tablerow">', $bb2html);	// a row
	$bb2html = str_replace('[/r]', '<!--row--></div>', $bb2html);

	$bb2html = str_replace('[box]', '<span class="box">', $bb2html);
	$bb2html = str_replace('[/box]', '<!--box--></span>', $bb2html);
	$bb2html = str_replace('[bbox]', '<div class="box">', $bb2html);
	$bb2html = str_replace('[/bbox]', '<!--box--></div>', $bb2html);

	// a simple list
	$bb2html = str_replace('[*]', '<li>', $bb2html);
	$bb2html = str_replace('[/*]', '</li>', $bb2html);
	$bb2html = str_replace('[ul]', '<ul>', $bb2html);
	$bb2html = str_replace('[/ul]', '</ul>', $bb2html);
	$bb2html = str_replace('[list]', '<ul>', $bb2html);
	$bb2html = str_replace('[/list]', '</ul>', $bb2html);
	$bb2html = str_replace('[ol]', '<ol>', $bb2html);
	$bb2html = str_replace('[/ol]', '</ol>', $bb2html);

	// fix up gaps..
	$bb2html = str_replace('</li><br />', '</li>', $bb2html);
	$bb2html = str_replace('<ul><br />', '<ul>', $bb2html);
	$bb2html = str_replace('</ul><br />', '</ul>', $bb2html);
	$bb2html = str_replace('<ol><br />', '<ol>', $bb2html);
	$bb2html = str_replace('</ol><br />', '</ol>', $bb2html);

	// smilies (just starting these, *ahem*) ..
	if (file_exists($_SERVER['DOCUMENT_ROOT'].$smilie_folder)) {
		$bb2html = str_replace(':lol:', '<img alt="smilie for :lol:" title=":lol:" src="'
		.$smilie_folder.'lol.gif" />', $bb2html);
		$bb2html = str_replace(':ken:', '<img alt="smilie for :ken:" title=":ken:" src="'
		.$smilie_folder.'ken.gif" />', $bb2html);
		$bb2html = str_replace(':D', '<img alt="smilie for :D" title=":D" src="'
		.$smilie_folder.'grin.gif" />', $bb2html);
		$bb2html = str_replace(':eek:', '<img alt="smilie for :eek:" title=":eek:" src="'
		.$smilie_folder.'eek.gif" />', $bb2html);
		$bb2html = str_replace(':geek:', '<img alt="smilie for :geek:" title=":geek:" src="'
		.$smilie_folder.'geek.gif" />', $bb2html);
		$bb2html = str_replace(':roll:', '<img alt="smilie for :roll:" title=":roll:" src="'
		.$smilie_folder.'roll.gif" />', $bb2html);
		$bb2html = str_replace(':erm:', '<img alt="smilie for :erm:" title=":erm:" src="'
		.$smilie_folder.'erm.gif" />', $bb2html);
		$bb2html = str_replace(':cool:', '<img alt="smilie for :cool:" title=":cool:" src="'
		.$smilie_folder.'cool.gif" />', $bb2html);
		$bb2html = str_replace(':blank:', '<img alt="smilie for :blank:" title=":blank:" src="'
		.$smilie_folder.'blank.gif" />', $bb2html);
		$bb2html = str_replace(':idea:', '<img alt="smilie for :idea:" title=":idea:" src="'
		.$smilie_folder.'idea.gif" />', $bb2html);
		$bb2html = str_replace(':ehh:', '<img alt="smilie for :ehh:" title=":ehh:" src="'
		.$smilie_folder.'ehh.gif" />', $bb2html);
		$bb2html = str_replace(':aargh:', '<img alt="smilie for :aargh:" title=":aargh:" src="'
		.$smilie_folder.'aargh.gif" />', $bb2html);
	}
	// anchors and stuff..
	$bb2html = str_replace('[img]', '<img class="cb-img" src="', $bb2html);
	$bb2html = str_replace('[imgr]', '<img class="cb-img-right" src="', $bb2html);
	$bb2html = str_replace('[imgl]', '<img class="cb-img-left" src="', $bb2html);
	$bb2html = str_replace('[/img]', '" alt="an image" />', $bb2html);

	// clickable mail URL ..
	$bb2html = preg_replace_callback("/\[mmail\=(.+?)\](.+?)\[\/mmail\]/i", "create_mmail", $bb2html);
	$bb2html = preg_replace_callback("/\[email\=(.+?)\](.+?)\[\/email\]/i", "create_mail", $bb2html);

	// other URLs..
	$bb2html = str_replace('[url=', '<a onclick="window.open(this.href); return false;" href=', $bb2html);
	$bb2html = str_replace('[turl=', '<a class="turl" title=', $bb2html); /* title-only url */
	$bb2html = str_replace('[purl=', '<a class="purl" href=', $bb2html); /* page url */
	$bb2html = str_replace('[/url]', '<!--url--></a>', $bb2html);

	// floaters..
	$bb2html = str_replace('[right]', '<div class="right">', $bb2html);
	$bb2html = str_replace('[/right]', '<!--right--></div>', $bb2html);
	$bb2html = str_replace('[left]', '<div class="left">', $bb2html);
	$bb2html = str_replace('[/left]', '<!--left--></div>', $bb2html);

	// code
	$bb2html = str_replace('[tt]', '<tt>', $bb2html);
	$bb2html = str_replace('[/tt]', '</tt>', $bb2html);
	$bb2html = str_replace('[code]', '<span class="code">', $bb2html);
	$bb2html = str_replace('[/code]', '<!--code--></span>', $bb2html);
	$bb2html = str_replace('[coderz]', '<div class="coderz">', $bb2html);
	$bb2html = str_replace('[/coderz]', '<!--coderz--></div>', $bb2html);

	// simple quotes..
	$bb2html = str_replace('[quote]', '<cite>', $bb2html);
	$bb2html = str_replace('[/quote]', '</cite>', $bb2html);

	// divisions..
	$bb2html = str_replace('[hr]', '<hr class="cb-hr" />', $bb2html);
	$bb2html = str_replace('[hr2]', '<hr class="cb-hr2" />', $bb2html);
	$bb2html = str_replace('[hr3]', '<hr class="cb-hr3" />', $bb2html);
	$bb2html = str_replace('[hr4]', '<hr class="cb-hr4" />', $bb2html);
	$bb2html = str_replace('[hrr]', '<hr class="cb-hr-regular" />', $bb2html);
	$bb2html = str_replace('[block]', '<blockquote><div class="blockquote">', $bb2html);
	$bb2html = str_replace('[/block]', '</div></blockquote>', $bb2html);
	$bb2html = str_replace('</div></blockquote><br />', '</div></blockquote>', $bb2html);

	$bb2html = str_replace('[mid]', '<div class="cb-center">', $bb2html);
	$bb2html = str_replace('[/mid]', '<!--mid--></div>', $bb2html);

	// dropcaps. five flavours, small up to large.. [dc1]I[/dc] -> [dc5]W[/dc]
	$bb2html = str_replace('[dc1]', '<span class="dropcap1">', $bb2html);
	$bb2html = str_replace('[dc2]', '<span class="dropcap2">', $bb2html);
	$bb2html = str_replace('[dc3]', '<span class="dropcap3">', $bb2html);
	$bb2html = str_replace('[dc4]', '<span class="dropcap4">', $bb2html);
	$bb2html = str_replace('[dc5]', '<span class="dropcap5">', $bb2html);
	$bb2html = str_replace('[/dc]', '<!--dc--></span>', $bb2html);

	$bb2html = str_replace('[h2]', '<h2>', $bb2html);
	$bb2html = str_replace('[/h2]', '</h2>', $bb2html);
	$bb2html = str_replace('[h3]', '<h3>', $bb2html);
	$bb2html = str_replace('[/h3]', '</h3>', $bb2html);
	$bb2html = str_replace('[h4]', '<h4>', $bb2html);
	$bb2html = str_replace('[/h4]', '</h4>', $bb2html);
	$bb2html = str_replace('[h5]', '<h5>', $bb2html);
	$bb2html = str_replace('[/h5]', '</h5>', $bb2html);
	$bb2html = str_replace('[h6]', '<h6>', $bb2html);
	$bb2html = str_replace('[/h6]', '</h6>', $bb2html);

	// fix up input spacings..
	$bb2html = str_replace('</h2><br />', '</h2>', $bb2html);
	$bb2html = str_replace('</h3><br />', '</h3>', $bb2html);
	$bb2html = str_replace('</h4><br />', '</h4>', $bb2html);
	$bb2html = str_replace('</h5><br />', '</h5>', $bb2html);
	$bb2html = str_replace('</h6><br />', '</h6>', $bb2html);

	// oh, all right then..
	// my [color=red]colour[/color] [color=blue]test[/color] [color=#C5BB41]test[/color]
	$bb2html = preg_replace('/\[color\=(.+?)\](.+?)\[\/color\]/i', "<span style=\"color:$1\">$2<!--color--></span>", $bb2html);

	// common special characters (html entity encoding) ..
	// still considering just throwing them all into the one php function. hmmm..
	$bb2html = str_replace('[sp]', '&nbsp;', $bb2html);
	$bb2html = str_replace('±', '&plusmn;', $bb2html);
	$bb2html = str_replace('™', '&trade;', $bb2html);
	$bb2html = str_replace('•', '&bull;', $bb2html);
	$bb2html = str_replace('°', '&deg;', $bb2html);
	$bb2html = str_replace('***lt***', '&lt;', $bb2html);
	$bb2html = str_replace('***gt***', '&gt;', $bb2html);
	$bb2html = str_replace('©', '&copy;', $bb2html);
	$bb2html = str_replace('®', '&reg;', $bb2html);
	$bb2html = str_replace('…', '&hellip;', $bb2html);

	// for URL's, and InfiniTags™..
	$bb2html = str_replace('[', ' <', $bb2html); // you can just replace < and >  with [ and ] in your bbcode
	$bb2html = str_replace(']', ' >', $bb2html); // for instance, [center] cool [/center] would work!

	// get back those square brackets..
	$bb2html = str_replace('**$@$**', '[', $bb2html);
	$bb2html = str_replace('**@^@**', ']', $bb2html);

	// prevent some twat running arbitary php commands on our web server
	// I may roll this into the xss prevention and just keep it all enabled. hmm.
	$bb2html = preg_replace("/<\?(.*)\? ?>/i", "<strong>script-kiddie prank: &lt;?\\1 ?&gt;</strong>", $bb2html);

	// re-insert the preformatted text blocks..
	$cp = count($pre) - 1;
	for ($i=0;$i <= $cp;$i++) {
		$bb2html = str_replace("***pre_string***$i", '<pre>'.$pre[$i].'</pre>', $bb2html);
	}

	// insert the cool colored code..
	$cp = count($ccc) - 1;
	for ($i=0 ; $i <= $cp ; $i++) {
		//$tmp_str = str_replace("\\", "&#92;", $ccc[$i]);
		$tmp_str = substr($ccc[$i], 5, -6);
		$tmp_str = highlight_string(stripslashes($tmp_str), true);
		$tmp_str = str_replace('font color="', 'span style="color:', $tmp_str);
		$tmp_str = str_replace('font', 'span', $tmp_str);
		$bb2html = str_replace("***ccc_string***$i", '<div class="cb-ccc">'.addslashes($tmp_str).'<!--ccccode--></div>', $bb2html);
	}


	// slash me!
	if (get_magic_quotes_gpc()) {
		return stripslashes($bb2html);
	} else {
		return $bb2html;
	}
}/* end function bb2html()
*/

/*
create_mail
a callback function for the email tag	*/
function create_mail($matches) {
	$removers = array('"','\\'); // in case they add quotes
	$mail = str_replace($removers,'',$matches[1]);
	$mail = str_replace(' ', '%20', bbmashed_mail($mail));
	return '<a title="mail me!" href="'.$mail.'">'.$matches[2].'</a>';
}

/*
create *my* email
a callback function for the mmail tag	*/
function create_mmail($matches) {
global $emailaddress;
	$removers = array('"','\\'); // in case they add quotes
	$mashed_address = str_replace($removers,'',$matches[1]);
	$mashed_address = bbmashed_mail($emailaddress.'?subject='.$mashed_address);
	$mashed_address = str_replace(' ', '%20', $mashed_address); // hmmm
	return '<a class="cb-mail" title="mail me!" href="'.$mashed_address.'\">'.$matches[2].'<!--mail--></a>';
}

echo bb2html(file_get_contents("/dev/stdin"));

?>
