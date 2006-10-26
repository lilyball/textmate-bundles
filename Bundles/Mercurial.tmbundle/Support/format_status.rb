
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
hg			         = ENV['TM_HG'].nil? ? "hg" : ENV['TM_HG']

require support + "/lib/Builder.rb"
require bundle + "/hg_helper.rb"
include HGHelper


mup = Builder::XmlMarkup.new(:target => STDOUT)

class << mup
	
	StatusMap = {	'A' => 'added',
   					'R' => 'deleted',
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

begin
make_head( "Hg Status", work_path,
           [ bundle+"/Stylesheets/hg_style.css",
             bundle+"/Stylesheets/hg_status_style.css"] )

		STDOUT.flush


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
						  elsif status == '!' or status == 'R'
						      # No need to link to Deleted or missing files.
						      mup.td_status!(status)
    							mup.td( file.sub( /^#{strip_path_prefix}\//, "") )
							else
    							mup.td_status!(status)
    							mup.td { mup.a( file.sub( /^#{strip_path_prefix}\//, ""), "href" => 'txmt://open?url=file://' + work_path + '/' + file, "class" => "pathanme" ) }
                            end
						end 
					else
						mup.td { mup.div( line, "class" => "error" ) }
					end
				}
			end
		}


rescue => e
   handle_default_exceptions( e )
ensure
   make_foot()
end
