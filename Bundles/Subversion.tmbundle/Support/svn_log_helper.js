/* a _very_ basic implementation of flipping
   the visibility of the changed files list.
   
   copyright 2005 torsten becker <torsten.becker@gmail.com>
   no warranty, that it doesn't crash your system.
   you are of course free to modify this.
*/

function didFinishCommand ()
{
   TextMate.isBusy = false;
}

// filename is already shell-escaped, URL is %-escaped
function export_file ( url, rev, filename )
{
   TextMate.isBusy = true;
   TextMate.system("\"${TM_SVN:=svn}\" cat -r" + rev + " '" + url + "' &>/tmp/" + filename + "; open -a TextMate /tmp/" + filename, didFinishCommand);
}

/* show: files + hide-button,  hide: show-button.. */
function show_files( base_id )
{
   document.getElementById( base_id ).style.display = 'block';
   document.getElementById( base_id+'_show' ).style.display = 'none';   
   document.getElementById( base_id+'_hide' ).style.display = 'inline';
}

/* hide: files + hide-button,  show: show-button.. */
function hide_files( base_id )
{
   document.getElementById( base_id ).style.display = 'none';
   document.getElementById( base_id+'_show' ).style.display = 'inline';   
   document.getElementById( base_id+'_hide' ).style.display = 'none';
}


function diff_and_open_tm( url, rev, filename )
{
	TextMate.isBusy = true;
	TextMate.system('"${TM_SVN:=svn}" diff --old "'+url+'@'+(rev-1)+'" --new "'+url+'@'+rev+'" &> '+filename+'; open -a TextMate '+filename, didFinishCommand );
	
// debug / experimental stuff:
//   TextMate.system('logger . "${TM_SUPPORT_PATH}/lib/bash_init.sh"', null );
//   TextMate.system('logger <<< `env`', null );
//	TextMate.system('. "${TM_SUPPORT_PATH}/lib/bash_init.sh"; \"${TM_SVN:=svn}\" 2>&1 diff --old '+url+'@'+(rev-1)+' --new '+url+'@'+rev+' >'+filename+' && open -a TextMate '+filename, didFinishCommand );
}
