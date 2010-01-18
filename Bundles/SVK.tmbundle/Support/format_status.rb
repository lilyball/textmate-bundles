bundle				= ENV['TM_BUNDLE_SUPPORT']
work_path			= ENV['WorkPath']
strip_path_prefix	= work_path # Dir.pwd
svk			= ENV['TM_SVK']
svk = "svk" if svk.nil?

require ENV['TM_BUNDLE_SUPPORT'] + '/lib/Builder.rb'


mup = Builder::XmlMarkup.new(:target => STDOUT)

class << mup
	# TODO this is the svn StatusMap, really need a new one here
	#      but these classes aren't used anyway
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
			mup.title("SVK status")
			mup.style( "@import 'file://"+bundle+"/css/svk_style.css';
						@import 'file://"+bundle+"/css/svk_status_style.css';", "type" => "text/css")
	}

	mup.body { 
		mup.h1("SVK Status for '#{File.basename(work_path)}'")
#		mup.hr
		mup.div("class" => "command"){ mup.strong("#{svk} status"); mup.text!(" " + work_path) } #mup.text!("checking "); 
		STDOUT.flush
		mup.hr

		mup.table("class" => "status") {
			STDIN.each_line do |line|
				
				mup.tr {
					if /^svk:/.match( line ).nil? then
						match = /^(...) (.*)/.match( line )
					
						if match.nil? then
							mup.td(line)
						else
							status	= match[1]
							file	= match[2]
							
							mup.td_status!(status)
							mup.td { mup.a( file.sub( /^#{strip_path_prefix}\//, ""), "href" => 'txmt://open?url=file://' + file, "class" => "pathname" ) }
						end 
					else
						mup.td { mup.div( line, "class" => "error" ) }
					end
				}
			end
		}
	}
}
