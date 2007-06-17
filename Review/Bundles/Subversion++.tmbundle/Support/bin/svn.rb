#!/usr/bin/env ruby

require "#{ENV["TM_SUPPORT_PATH"]}/lib/escape"
require "#{ENV["TM_SUPPORT_PATH"]}/lib/web_preview"
require "erb"
include ERB::Util

# TODO: 16:56 < allan> probably the web_preview stuff could go to TextMate::HTML
# 16:56 < allan> and I think we should do: Support/lib/textmate/* for the various modules we add to TextMate
# 16:57 < allan> maybe do one big refactoring instead of incremental changes though…
# 16:57 < allan> escape also ought to be in the TextMate namespace
# 16:57 < allan> but presumably with an easy way to include it
# 16:58 < allan> so we can do e_sh instead of TextMate::Escape.e_sh :)
module TM_Helper
  
  require "Date"
  
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
  def make_tm_link(filename, line = nil)
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
  
  # formates you date (input should be a standart svn date)
  # if format is nil it just gives you back the current date
  def formated_date(input, format = nil)
     if not format.nil? and input =~ /^\s*(\d+)-(\d{2})-(\d{2}) (\d{2}):(\d{2}):(\d{2}) .+$/
        #            year     month    day      hour     minutes  seconds
        Time.mktime( $1.to_i, $2.to_i, $3.to_i, $4.to_i, $5.to_i, $6.to_i ).strftime( format )
     else
        DateTime.parse(input).strftime("%Y/%m/%d %I:%M:%S")
     end
  end
  
  
  # the same as the above 2 methods, just for errors.
  def make_error_head(title = '', head_adds = '')
     puts '<div class="error"><h2>'+title+'</h2>'+head_adds
  end
  
  # .. see above.
  def make_error_foot(foot_adds = '')
     puts foot_adds+'</div>'
  end
  
  
  # used to handle the normal exceptions like
  # NoMatchException, SVNErrorException and unknown exceptions.
  def handle_default_exceptions(e, stdin = $stdin)
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
  def merge_line_and_state(line, state)
     "\"#{line}\" in state :#{state}"
  end
  
  # first escape for use in the shell, then escape for use in a JS string
  def e_js_sh(str)
    (e_sh str).gsub("\\", "\\\\\\\\")
  end
  
end

class TM_Svn
  include TM_Helper
  
  def initialize
    @full_file     = ENV['TM_FILEPATH']
    @tm_line       = ENV['TM_LINE_NUMBER'].to_i
    @tab_size      = ENV['TM_TAB_SIZE'].to_i
    @bundle        = ENV['TM_BUNDLE_SUPPORT']
    @date_format   = ENV['TM_SVN_DATE_FORMAT'].nil? ? nil : ENV['TM_SVN_DATE_FORMAT']
    @close_window  = (ENV['TM_SVN_CLOSE'].nil? or ENV['TM_SVN_CLOSE'].strip != 'true' or
                        ENV['TM_SVN_CLOSE'].strip != '1') ? false : true
                        
    @cmd_base = "RUBYLIB=#{e_js_sh "#{ENV['TM_SUPPORT_PATH']}"} #{e_js_sh "#{ENV['TM_BUNDLE_SUPPORT']}/bin/svn.rb"} 2>&1";

    @head_extra = ERB.new(
      File.read(
        "#{ENV['TM_BUNDLE_SUPPORT']}/templates/svn_head.erb")).result(binding)
    
  end
  
  
  def blame(args)
    js_mode = args.length > 0 and args[0] == 'js';
    
    revision_comment = []
    revision_number = 0
    `"${TM_SVN:=svn}" log "$TM_FILEPATH" 2>&1`.each_line {|line|
      if line =~ /^r(\d*)/ then
        revision_number = $1.to_i
        revision_comment[revision_number] = ''
      else
        if line !~ /^-----/ then
          revision_comment[revision_number] = revision_comment[revision_number].nil? ?
            line : revision_comment[revision_number] + line
        end
      end
    }

    puts html_head(:window_title => "Blame for “" + @full_file.sub( /^.*\//, '') + "”", :page_title => @full_file.sub( /^.*\//, ''), :sub_title => 'Subversion', :html_head => @head_extra) unless js_mode
    STDOUT.flush
    puts(ERB.new(File.read("#{ENV['TM_BUNDLE_SUPPORT']}/templates/blame_head.erb")).result(binding))

    prev_rev = 0
    linecount = 0
    
    `"${TM_SVN:=svn}" blame -v "$TM_FILEPATH" 2>&1`.each_line do |line|
      # raise SVNErrorException, line  if line =~ /^svn:/
      # not a perfect pattern, but it works and is short:
      # catched groups: revision, user, date, text/code
      if line =~ /^\s*(\d+)\s+([^\s]+) (\d+-\d+-\d+ \d+:\d+:\d+ [-+]\d+ \(\w+, \d+ \w+ \d+\)) (.*)$/u
        linecount += 1

        revision = $1.to_i
        name     = $2
        date     = $3
        content  = $4
        
        anchor_line  = (@tm_line == linecount + 10)
        current_line = (@tm_line == linecount)
        file_link    = make_tm_link(@full_file, linecount)
         puts(ERB.new(File.read("#{ENV['TM_BUNDLE_SUPPORT']}/templates/blame_item.erb")).result(binding))
      end
      prev_rev = $1.to_i
    end
    puts(ERB.new(File.read("#{ENV['TM_BUNDLE_SUPPORT']}/templates/blame_tail.erb")).result(binding))
    html_footer() unless js_mode
  end
  
  
  def info(args)
    require 'rexml/document'

    js_mode = args.length > 0 and args[0] == 'js';
    
    @show          = ENV['TM_SVN_INFO_SHOW'].nil? ? [] :
                        ENV['TM_SVN_INFO_SHOW'].split(/\s*,\s*/).each { |s| s.downcase! }
    @hide          = ENV['TM_SVN_INFO_HIDE'].nil? ? [] :
                        ENV['TM_SVN_INFO_HIDE'].split(/\s*,\s*/).each { |s| s.downcase! }
    @hide_all      = (@hide.include? '*') ? true : false
    
    puts html_head(:window_title => "Info", :page_title => "SVN Info", :sub_title => 'Subversion', :html_head => @head_extra) unless js_mode

    STDOUT.flush

    linecount = 0
    got_newline = false
        
    document = REXML::Document.new(`"${TM_SVN:=svn}" info --xml "$TM_FILEPATH" 2>&1`)
    puts(ERB.new(File.read("#{ENV['TM_BUNDLE_SUPPORT']}/templates/info.erb")).result(binding))

    html_footer() unless js_mode
  end
  
  
end

command = ARGV.shift
svn = TM_Svn.new
svn.send(command, ARGV) if svn.methods.include?(command)
