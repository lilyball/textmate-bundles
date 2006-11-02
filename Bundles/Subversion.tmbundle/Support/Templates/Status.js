//
//  JavaScript library for SVN status.
//	Thomas Aylott and Chris Thomas.
//
//	Requires global variables StatusMap and ENV.
//
//	ENV must be set up with:
//
//		PATH
//      TM_SUPPORT_PATH
//		TM_BUNDLE_SUPPORT
//      CommitWindow
//      TM_SVN
//		TM_RUBY
//

the_filename    = null;
the_id          = null;
the_displayname = null;
the_new_status  = null;

function svnCommand(cmd, id, statusString, className){
	TextMate.isBusy = true;

	results        = TextMate.system('LC_CTYPE=en_US.UTF-8 ' + cmd, null)
	outputString   = results.outputString;
	errorString = results.errorString;
	errorCode      = results.status;

	displayCommandOutput('error', 'error', errorString);
	displayCommandOutput('info', 'info', outputString);
	
	if(errorCode == 0 && id != null)
	{
		status_element = document.getElementById('status'+id)
		status_element.innerHTML = statusString;
		status_element.className = 'status_col ' + className;
	}

	TextMate.isBusy = false;
}

function displayCommandOutput(id, className, string){
	
	if(string != null && string != '')
	{
//		tail_id = 'tail_' + id
//		tail_div = document.getElementById(tail_id);
//		if(tail_div == null)
//		{
//			status_div = document.getElementById('commandOutput');
//			tail_div = document.createElement('div');
//			tail_div.setAttribute('id', tail_id);
//			tail_div.setAttribute('class', className);
//			status_div.appendChild(tail_div);
//		}
//
//		tail_div.innerHTML = string;
		
		console_div = document.getElementById('console')
		console_div.style.display = 'inline';
		
		string += " \n";
		document.getElementById('commandOutput').innerHTML += string;
	}
}

function svnCommit(){
		
	cmd = ""
	cmd += 'export LC_CTYPE=en_US.UTF-8 ;'
	cmd += "export            PATH="			+ ENV['PATH']				+ "; "
	cmd += "export            TM_SVN="			+ ENV['TM_SVN']				+ "; "
	cmd += "export            TM_SUPPORT_PATH="	+ ENV['TM_SUPPORT_PATH']	+ "; "
	cmd += "export            CommitWindow="	+ ENV['CommitWindow'] 		+ "; "

	if(ENV['TM_SVN_DIFF_CMD']) {
		cmd += "export        TM_SVN_DIFF_CMD="	+ ENV['TM_SVN_DIFF_CMD']	+ "; "
	}

	cmd += ENV['TM_RUBY'] + ' -- ' + ENV['TM_BUNDLE_SUPPORT'] + '/svn_commit.rb "' + WorkPaths.join('" "') + '"'

//	displayCommandOutput('info', 'info', cmd);
//	document.getElementById('commandOutput').innerHTML = TextMate.system(cmd, null).outputString + ' \\n'
	
	TextMate.isBusy = true
	myCommand = TextMate.system(cmd, function (task) { TextMate.isBusy = false; });
	myCommand.onreadoutput = svnReadOutput;
	myCommand.onreaderror = svnReadError;
};

function svnAddFile(filename,id){
	
	displayCommandOutput('info', 'info', 'Adding ' + filename)
	
	cmd = ENV['TM_SVN'] + ' add ' + filename + ' 2>&1'

	svnCommand(cmd, id, 'A', StatusMap['A'])
};

function svnRevertFile(filename,id){
	cmd = ENV['TM_SVN'] + ' 2>&1 revert ' + filename;
	svnCommand(cmd, id, '?', StatusMap['?'])
};

function completedTask(task){
	
	if (task.status == 0)
	{
		if(the_new_status == '-'){document.getElementById('status'+the_id).className = 'status_col ' + StatusMap['-']};
		if(the_new_status == 'D'){document.getElementById('status'+the_id).className = 'status_col ' + StatusMap['D']};
		document.getElementById('status'+the_id).innerHTML = the_new_status;
	}

	the_filename    = null;
	the_id          = null;
	the_displayname = null;
	the_new_status  = null;	

	TextMate.isBusy = false;
}

function svnRevertFileConfirm(filename,id,displayname){
	the_filename    = filename;
	the_id          = id;
	the_displayname = displayname;
	the_new_status  = '?';
	cmd = 'LC_CTYPE=en_US.UTF-8 ' + ENV['TM_BUNDLE_SUPPORT'] + '/revert_file.rb -svn=' + ENV['TM_SVN'] + ' -path=' + filename + ' -displayname=' + displayname;

	TextMate.isBusy = true;
	myCommand = TextMate.system(cmd, completedTask);
	myCommand.onreadoutput = svnReadOutput;
	myCommand.onreaderror = svnReadError;
};

function svnRemoveFile(filename,id,displayname){
	the_filename    = filename;
	the_id          = id;
	the_displayname = displayname;
	the_new_status  = 'D';
	TextMate.isBusy = true;
	cmd = 'LC_CTYPE=en_US.UTF-8 ' + ENV['TM_BUNDLE_SUPPORT'] + '/remove_file.rb -svn=' + ENV['TM_SVN'] + ' -path=' + filename + ' -displayname=' + displayname;
	
	myCommand = TextMate.system(cmd, completedTask);
	myCommand.onreadoutput = svnReadOutput;
	myCommand.onreaderror = svnReadError;
};

function svnReadOutput(str){
	// FIXME: Committing will output a while new page!
	// str = str.replace(/</g, '&lt;')
	// str = str.replace(/>/g, '&gt;')
	// str = str.replace(/"/g, '&quot;')
	displayCommandOutput('info', 'info', str);
};

function svnReadError(str){
	displayCommandOutput('error', 'error', str);
};

function openWithFinder(filename,id){
	TextMate.isBusy = true;
	cmd = "open 2>&1 " + filename;
	output = TextMate.system(cmd, null).outputString;
	displayCommandOutput('info', 'info', output);
	TextMate.isBusy = false;
};

function sendDiffToTextMate(filename,id){
	TextMate.isBusy = true;
	tmp = '/tmp/diff_to_mate' + id + '.diff'
	cmd = 'LC_CTYPE=en_US.UTF-8 ' + ENV['TM_SVN'] + ' 2>&1 diff --diff-cmd diff ' + filename + ' >' + tmp + ' && open -a TextMate ' + tmp
	document.getElementById('commandOutput').innerHTML += TextMate.system(cmd, null).outputString + ' \n'
	TextMate.isBusy = false;
};
