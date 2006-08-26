
support = ENV['TM_SUPPORT_PATH']
require (support + "/lib/Builder.rb")

CSSStyle = <<ENDSTYLE #CSS
 /* general stuff.. */
 body {
	font-family: "Lucida Grande", Verdana, Arial, sans-serif;
	font-size: 12px;
 }
 
 h1 {
	font-size: 165%;
	border-bottom: 3px solid #ccc;
	padding-bottom: 4px;
	margin-bottom: 2px;
	color: #222;
 }
 
 h2,h3,h4,h5,h6 {
	font-size: 135%;
	border-bottom: 2px solid #ddd;
	padding-bottom: 4px;
	margin-top: 26px;
	color: #333;
 }
 
 
 /* formating the definition lists.. **/
 dt {
	font-weight: bold;
	margin-top: 8px;
	margin-bottom: 2px;
	font-size: 115%;
	border-top: 1px dashed #ccc;
	padding-top: 10px;
	color: #333;
 }
 /* no top-border for the first thing, so it looks
	like there is a hr between all. */
 dl > dt:first-child {
	border-top: 0;
	padding-top: 0;
 }
  
 /* info fields: */
 div.target:before {
	font-weight: bold;
	content: "Target: ";
 }
 
 div.description {
	margin-top: 4px;
 }
 
 span.connect {
	font-weight: bold;
	font-size: 130%;
 }
 
 div.default:before {
	font-weight: bold;
	content: "Default: ";
 }
ENDSTYLE



builder = Builder::XmlMarkup.new(:target => STDOUT)


# custom structuring
class << builder
	
	def command( options )
		self.dt do
			name = options[:name]
			self.a(:name => name.downcase) { self << name }
			# phone home? use telephone symbol
		 	self.span(:class => 'connect', :title => "'#{name}' will contact the server") do
				self << "   " + [0x2706].pack('U*')
			end unless options[:connect].nil?
		end
		self.dd do
			self.div(:class => 'target') { self << (options[:target]) } unless options[:target].nil?
			self.div(:class => 'description') { self << options[:description] }
		end
	end
	
	def command_group(name, &block)
		self.div(:class => 'group') do
			self.h2 { self.a(:name => name) { self << name } }
			block.call
		end
	end
	
end

#
# HTML output
#
builder.html do
	builder.head do
		builder.title("Subversion Help")
		builder.style( :type => "text/css" ) { builder << CSSStyle }
		builder.meta( :'http-equiv' => "Content-Type", :content => "text/html; charset=UTF-8" )
	end
	
	builder.body do
		builder.h1 "Subversion Help"
		builder.p do
			builder << "This document describes the commands of the TextMate Subversion bundle and how you can <a href=\"#conf\">fine-tune</a> their behavior. For general Subversion help and tutorial, you should read the <a title=\"Version Control with Subversion\" href=\"http://svnbook.red-bean.com/\">Subversion book</a>."
		end
		
		builder.command_group( 'Basic Commands' ) do
#			builder.p "Diff commands operate on selected project files/folders or the active file if it doesn\'t belong to a project."
			builder.dl do
				 builder.command(:name => "Add to Repository",
				:description => "Schedules the targets for addition to the repository.")

				 builder.command(:name => "Remove from Repository",
				:description => "Schedules the targets for removal from the repository.")

			 	builder.command(:name => "Revert",
				:target => "active file",
				:description => "Reverts the file to the base revision. Any modifications to the file will be lost.")

				builder.command(:name => "Update to Newest",
				:connect => "Yes",
				:description => "Updates the targets with the newest changes from the repository.")

				builder.command(:name => "Commit",
				:connect => "Yes",
				:description => " Commits your changed files to the repository. A dialog asks you for the description of
						your changes; you may also choose to exclude files from the commit by unchecking them.
						If no files are selected or active, this command does nothing. If the target files
						have no local changes, nothing happens.
				   ")
			end
		end
		
		
		builder.command_group( 'Difference Commands' ) do
			builder.p "Diff commands operate on selected project files/folders or the active file if it doesn\'t belong to a project."

			builder.dl do
				builder.command(:name => "Diff Revisions&hellip;",
				:connect => "Yes",
				:description => "Displays the differences between two specific revisions of the active file. You will be presented with a list of revisions; please select two.")

				builder.command(:name => "Diff With Newest (HEAD)",
				:connect => "Yes",
				:description => "
					Displays the differences between the active file and the newest available revision of the file on the server.
					Equivalent to <code>svn diff -rHEAD</code>.
				   ")
			
				builder.command(:name => "Diff With Working Copy (BASE)",
				:description => "
					  Displays the differences between the active file and an unaltered, pristine copy of the file at the same revision.
					  Equivalent to <code>svn diff -rBASE</code>.
				   ")
			
				builder.command(:name => "Diff With Previous Revision (PREV)",
				:connect => "Yes",
				:description => "
					  Displays the differences between the active file and the previous revision of the file.
					  Equivalent to <code>svn diff -rPREV</code>.
				   ")

				builder.command(:name => "Diff With Revision&hellip;",
				:connect => "Yes",
				:description => "Displays the differences between the active file and a different revision of the same file. This command presents you with a list of revisions to choose from.")
			end
		end

		builder.command_group( 'History and Info Commands' ) do
			builder.dl do
				 builder.command(:name => "Blame",
				:target => "active file",
				:connect => "Yes",
				:description => "Displays a line-by-line history of the file, showing you who wrote which line in what revision.	 Click a line to jump to it in an editor window.  Hover over a revision number or author name to see when the corresponding line was last changed. The date format is <a href=\"#tm_svn_date_format\">adjustable</a>.")

				builder.command(:name => "Info",
				:description => "
					  Displays detailed information about the selected files, including the type of file, who last changed the file, the date file was last changed, the repository URL to the file, and other information.
					  Some parameters are configurable via shell variables; see the <a href=\"#tm_svn_info\">Configuration Options</a> section below.")			

				builder.command(:name => "Log",
				:connect => "Yes",
				:description => "Displays the commit message history for the selected files. Some parameters are configurable via shell variables; see the <a href=\"#tm_svn_log\">Configuration Options</a> section below. ")
				
				builder.command(:name => "Status",
				:target => "directory of active file",
				:description => "Displays a list of files with changes in your working copy, along with the type of change for each file.")

				builder.command(:name => "View Revision&hellip;",
				:target => "active file",
				:connect => "Yes",
				:description => "Displays a different revision of the active file. This command presents you with a list of revisions to choose from.")
			end

		end
		
		builder.command_group( 'Merge Commands' ) do
#			builder.p "Diff commands operate on selected project files/folders or the active file if it doesn\'t belong to a project."
			builder.dl do
				builder.command(:name => "Resolved",
				:target => "active file",
				:description => "Removing the conflict-related artifact files, allowing the file to be committed. Does not remove conflict markers or resolve textual conflicts.")
			end
		end
						
	end
end

__END__

<html>
   
   <body>

	  <h2><a name="conf">Configuration Options</a></h2>
		 
		 <p>These shell variables allow you to tweak the behavior of the certain commands if need be. The default values should make sense for normal use.</p>
		 
		 <dl>
			<dt><a name="tm_svn">$TM_SVN</a></dt>
			<dd>
			   <div class="default"><code>svn</code></div>
			   <div class="description">the path to your svn executable.</div>
			</dd>
			
			<dt><a name="tm_svn_diff_cmd">$TM_SVN_DIFF_CMD</a></dt>
			<dd>
			   <div class="default"><em>not set</em></div>
			   <div class="description">Allows you to set a command that should be used to present file differences. If you want to have differences shown using Apple’s FileMerge then you can use <a href="http://ssel.vub.ac.be/ssel/internal:fmdiff">fmdiff</a>.</div>
			</dd>
			
			<dt><a name="tm_ruby">$TM_RUBY</a></dt>
			<dd>
			   <div class="default"><code>ruby</code></div>
			   <div class="description">Here you can tweak with what Ruby the formatting scripts will be executed.</div>
			</dd>
			
			<dt><a name="tm_svn_date_format">$TM_SVN_DATE_FORMAT</a></dt>
			<dd>
			   <div class="default"><em>not set</em> (No Changes, just show what SVN shows)</div>
			   <div class="description">
				  A date format string that allows you to tweak the format in which <a href="#blame">Blame</a>, <a href="#log">Log</a> and <a href="#info">Info</a> show you dates.	 See <a title="Manual Page For strftime(3)" href="http://developer.apple.com/documentation/Darwin/Reference/ManPages/man3/strftime.3.html">strftime(3)</a> for what you can enter here.
			   </div>
			</dd>
			
			<dt><a name="tm_svn_close">$TM_SVN_CLOSE</a></dt>
			<dd>
			   <div class="default"><code>false</code></div>
			   <div class="description">With this option you can adjust whether the windows of <a href="#blame">Blame</a> and <a href="#info">Info</a> close if you click on a link which opens a file in TM.  Set it to <code>1</code> or <code>true</code> if windows should close or to something else if they should not.</div>
			</dd>
			
			<dt><a name="tm_svn_log">$TM_SVN_LOG_RANGE</a></dt>
			<dd>
			   <div class="default"><code>BASE:1</code></div>
			   <div class="description">The default range to query for log messages.</div>
			</dd>
			
			<dt>$TM_SVN_LOG_LIMIT</dt>
			<dd>
			   <div class="default"><code>15</code></div>
			   <div class="description">The number of messages to show.	 <code>0</code> means no limit.</div>
			</dd>
			
			<dt><a name="tm_svn_info">$TM_SVN_INFO_HIDE</a></dt>
			<dd>
			   <div class="default"><em>not set</em> (nothing)</div>
			   <div class="description">
				  Here you can adjust what keys of the info stream you don't want to see, it is case insensitive and a comma (<code>,</code>) separated list.  If you enter a <code>*</code>, it is assumed that you want to hide all vars, if so, you can make some values visible again with <strong>$TM_SVN_INFO_SHOW</strong>.
			   </div>
			</dd>
			
			<dt>$TM_SVN_INFO_SHOW</dt>
			<dd>
			   <div class="default"><em>not set</em> (everything else)</div>
			   <div class="description">
				  This is also a comma separated list of keys, it just makes sense if you did hide all with the above var.	 <em>*</em> has no special meaning here. Everything you enter here will be shown if you want to hide everything else.
			   </div>
			</dd>
			
		 </dl>
	  
	  
	  <h2><a name="authors">Authors</a></h2>
		 
		 <ul>
			<li>Chris Thomas (Idea, Status, Diffs, Commit, Add, and Updates)</li>
			<li>Torsten Becker (Blame, Log, Info, and Revert)</li>
			<li>Thomas Aylott (Status <em title="Add, Remove, Diff and CSS slickness in the Status window">Fancification</em>)</li>
		 </ul>
		 
   </body>
   
</html>
