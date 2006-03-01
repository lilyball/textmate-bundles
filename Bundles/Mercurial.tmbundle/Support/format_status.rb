
# status or update?
$is_status = false

ARGV.each {|arg| $is_status = true if arg == "--status"}

command_name = if $is_status then
	"status"
else
	"update"
end

bundle				= ENV['TM_BUNDLE_SUPPORT']
support				= ENV['TM_SUPPORT_PATH']
work_path			= ENV['WorkPath']
ignore_file_pattern = /(\/.*)*(\/\..*|\.(tmproj|o|pyc)|Icon)/

strip_path_prefix	= work_path # Dir.pwd
hg			= ENV['TM_HG']
hg = "hg" if hg.nil?

require (support + "/bin/Builder.rb")


mup = Builder::XmlMarkup.new(:target => STDOUT)

class << mup
	
	StatusMap = {	'A' => 'added',
					'D' => 'deleted',
					'G' => 'merged',
					'U' => 'updated',
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
			mup.title("Mercurial #{command_name}")
			mup.style( "@import 'file://"+bundle+"/Stylesheets/hg_style.css';
						@import 'file://"+bundle+"/Stylesheets/hg_status_style.css';", "type" => "text/css")
	}

	mup.body { 
		mup.h1("Mercurial #{command_name} for '#{File.basename(work_path)}'")
#		mup.hr
		mup.div("class" => "command"){ mup.strong("#{hg} #{command_name}"); mup.text!(" " + work_path) } #mup.text!("checking "); 
		STDOUT.flush
		mup.hr

		mup.table("class" => "status") {
			STDIN.each_line do |line|
				
				mup.tr {
					if /^hg:/.match( line ).nil? then
						
						match = if $is_status then
							/^(.)(?:\s+)(.*)\n/.match( line )
						else
							/^(.)(?:\s+)(.*)\n/.match( line )
						end
						
						if match.nil? then
							mup.td("")
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
