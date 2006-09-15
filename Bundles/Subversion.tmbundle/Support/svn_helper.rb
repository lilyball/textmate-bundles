# just some small methods and some exceptions to help
# with converting some of the svn command outputs to html.
# 
# by torsten becker <torsten.becker@gmail.com>, 2005/06
# no warranty, that it doesn't crash your system.
# you are of course free to modify this.


module SVNHelper   
   # (log) raised, if the maximum number of log messages is shown.
   class LogLimitReachedException < StandardError; end
   
   # (log) thrown when a parser ended in a state that wasn't expected
   class UnexpectedFinalStateException < StandardError; end
   
   # (all) raised if the 'parser' gets a line
   # which doesnt match a certain scheme or wasnt expected
   # in a special state.
   class NoMatchException < StandardError; end
   
   # (all) if we should go in error mode
   class SVNErrorException < StandardError; end
   
   
   # makes a txmt-link for the html output, the line arg is optional.
   def make_tm_link( filename, line=nil )
      encoded_file_url = ''
      ('file://'+filename).each_byte do |b|
         if b.chr =~ /\w/
            encoded_file_url << b.chr
         else
            encoded_file_url << sprintf( '%%%02x', b )
         end
      end
      
      'txmt://open?url=' + encoded_file_url + ((line.nil?) ? '' : '&amp;line='+line.to_s)
   end
   
   # subsitutes some special chars for showing html..
   def htmlize( string, blow_up_spaces = true, tab_size = $tab_size )
      string = string.gsub(/&/n, '&amp;').gsub(/\"/n, '&quot;').gsub(/</n, '&lt;')
      string = string.gsub(/\t+/, '<span style="white-space:pre;">\0</span>')
      string.reverse.gsub(/ (?= |$)/, ';psbn&').reverse
   end
   
   
   # formates you date (input should be a standart svn date)
   # if format is nil it just gives you back the current date
   def formated_date( input, format=$date_format )
      if not format.nil? and input =~ /^\s*(\d+)-(\d{2})-(\d{2}) (\d{2}):(\d{2}):(\d{2}) .+$/
         #            year     month    day      hour     minutes  seconds
         Time.mktime( $1.to_i, $2.to_i, $3.to_i, $4.to_i, $5.to_i, $6.to_i ).strftime( format )
      else
         input
      end
   end
   
   
   # produces a generic header..
def make_head( title='', styles=Array.new, head_adds=''  )
	tm_EXTRA_HEAD   = head_adds
	tm_CSS          = `cat "${TM_SUPPORT_PATH}/css/webpreview.css" | sed "s|TM_SUPPORT_PATH|${TM_SUPPORT_PATH}|"`
	tm_THEME        = `defaults 2>/dev/null read com.macromates.textmate.webpreview SelectedTheme`.rstrip
	
	tm_THEME = tm_THEME == '' ? 'bright' : tm_THEME;
	
	tm_THEMES = ''
	themes = ['bright', 'dark'];
	themes.each { |theme|
		x = theme == tm_THEME ? ' selected="selected" ' : '';
		tm_THEMES += '<option ' + x + ' >' + theme + '</option>\n'
	}
	
	html =<<-HTML
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
   <title>Subversion — #{title}</title>
	<style type="text/css" media="screen">
		#{tm_CSS}
	</style>
	<script src="file://#{ENV['TM_SUPPORT_PATH']}/script/default.js" type="text/javascript" language="javascript" charset="utf-8"></script>
	<script src="file://#{ENV['TM_SUPPORT_PATH']}/script/webpreview.js" type="text/javascript" language="javascript" charset="utf-8"></script>
	#{tm_EXTRA_HEAD}
</head>
<body id="tm_webpreview_body" class="#{tm_THEME}">
	<div id="tm_webpreview_header">
		<p class="headline">#{title}</p>
		<p class="type">Subversion</p>
		<img class="teaser" src="file://#{ENV['TM_SUPPORT_PATH']}/images/gear2.png" alt="teaser" />
		<div id="theme_switcher">
			<form action="#" onsubmit="return false;">
				Theme: 
				<select onchange="selectTheme(this.value);" id="theme_selector">
					#{tm_THEMES}
				</select>
			</form>
		</div>
	</div>
	<div id="tm_webpreview_content" class="#{tm_THEME}">
	<div class="subversion">
HTML
      puts html
		styles.each do |style|
         puts "<!--   @import 'file://"+style+"'; -->"
      end
   end
   
   # .. and this a simple, matching footer ..
   def make_foot( foot_adds='' )
      puts foot_adds+'</div></div></body></html>'
   end
   
   
   # the same as the above 2 methods, just for errors.
   def make_error_head( title='', head_adds='' )
      puts '<div class="error"><h2>'+title+'</h2>'+head_adds
   end
   
   # .. see above.
   def make_error_foot( foot_adds='' )
      puts foot_adds+'</div>'
   end
   
   
   # used to handle the normal exceptions like
   # NoMatchException, SVNErrorException and unknown exceptions.
   def handle_default_exceptions( e, stdin=$stdin )
   	case e
   	when NoMatchException
         make_error_head( 'No Match' )
         
         puts 'mhh, something with with the regex or svn must be wrong.  this should never happen.<br />'
         puts "last line: <em>#{htmlize($!)}</em><br />please bug-report."
         
         make_error_foot()
         
      when SVNErrorException
         make_error_head( 'SVN Error', htmlize( $! )+'<br />' )
         stdin.each_line { |line| puts htmlize( line )+'<br />' }
         make_error_foot()
         
      when UnexpectedFinalStateException
         make_error_head('Unexpected Final State')
         puts 'the parser ended in the final state <em>'+ $! +'</em>, this shouldnt happen. <br /> please bug-report.'
         make_error_foot
         
      # handle unknown exceptions..
      else
         make_error_head( e.class.to_s )
         
         puts 'reason: <em>'+htmlize( $! )+'</em><br />'
         trace = ''; $@.each { |e| trace+=htmlize('  '+e)+'<br />' }
         puts 'trace: <br />'+trace
         
         make_error_foot()
         
      end #case
      
   end #def handle_default_exceptions
   
   
   # used when throwing a NoMatchException to also tell the state,
   # because you can only pass 1 string to raise you have to cat them together.
   def merge_line_and_state( line, state )
      "\"#{line}\" in state :#{state}"
   end
   
end #module SVNHelper
