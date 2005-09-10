bundle				= ENV['TM_BUNDLE_PATH']
support				= ENV['TM_SUPPORT_PATH']
work_path			= ENV['WorkPath']
ignore_file_pattern = /(\/.*)*(\/\..*|\.(tmproj|o|pyc)|Icon)/

strip_path_prefix	= work_path # Dir.pwd
svn			= ENV['TM_SVN']
svn = "svn" if svn.nil?

require (support + "/bin/Builder.rb")


mup = Builder::XmlMarkup.new(:target => STDOUT)

class << mup
	
	StatusMap = {	'A' => 'added',
					'D' => 'deleted',
					'M' => 'modified',
					'C' => 'conflict',
					'!' => 'missing',
					'"' => 'typeconflict',
					'?' => 'unknown',
					'I' => 'ignore',
					'X' => 'external' }
	
	def td_status!(status)
		status.each_byte { |s| c = s.chr; td(c, "class" => StatusMap[c]) }
	end
end

mup.html {
	mup.head {
			mup.title("Subversion status")
			mup.style( "@import 'file://"+bundle+"/Stylesheets/svn_style.css';
						@import 'file://"+bundle+"/Stylesheets/svn_status_style.css';", "type" => "text/css")
	}

	mup.body { 
		mup.h1("Subversion Status for '#{File.basename(work_path)}'")
#		mup.hr
		mup.div("class" => "command"){ mup.strong("#{svn} status"); mup.text!(" " + work_path) } #mup.text!("checking "); 
		STDOUT.flush
		mup.hr

		mup.table("class" => "status") {
			STDIN.each_line do |line|
				
				mup.tr {
					if /^svn:/.match( line ).nil? then
						match = /^(.....)(?:\s+)(.*)\n/.match( line )
					
						if match.nil? then
							mup.td(line)
						else
							status	= match[1]
							file	= match[2]

							if status == '?    ' and ignore_file_pattern =~ file
							    # This is a file that we don't want to know about
							    nil
							else
    							mup.td_status!(status)
    							mup.td { mup.a( file.sub( /^#{strip_path_prefix}\//, ""), "href" => 'txmt://open?url=file://' + file, "class" => "pathanme" ) }
                            end
						end 
					else
						mup.td { mup.div( line, "class" => "error" ) }
					end
				}
			end
		}
	}
}
