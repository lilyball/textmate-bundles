bundle			= ENV['TM_BUNDLE_PATH']
work_path		= ENV['WorkPath']
pwd				= Dir.pwd
#svn			= ENV['TM_SVN']
#svn = "svn" if svn.nil?

require (bundle + "/Tools/Builder.rb")


mup = Builder::XmlMarkup.new(:target => STDOUT)
mup.html {
	mup.head {
			mup.title("Subversion status")
			mup.style( "@import 'file://"+bundle+"/Stylesheets/svn_style.css';", "type" => "text/css")
	}

	mup.body { 
		mup.h1("Subversion status")
		mup.hr
		mup.div("class" => "command"){ mup.text!("checking "); mup.tt(work_path) }
		STDOUT.flush
		mup.hr

		mup.table {
			STDIN.each_line do |line|
				
				mup.tr {
					if /^svn:/.match( line ).nil? then
						match = /^(.*?)(?:\s+)(.*)\n/.match( line )
						status	= match[1]
						file	= match[2]
					
						if match.nil? then
							mup.td(line)
						else
							mup.td(status)
							mup.td { mup.a( file.sub( /^#{pwd}\//, ""), "href" => 'txmt://open?url=file://' + file ) }
						end 
					else
						mup.td { mup.div( line, "class" => "error" ) }
					end
				}
			end
		}
	}
}
