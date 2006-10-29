#!/usr/bin/env ruby -w

$LOAD_PATH << ENV['TM_SUPPORT_PATH'] + "/lib"
$LOAD_PATH << ENV['TM_SUPPORT_PATH'] + "/bin"
require 'progress'
require 'exit_codes'
require 'shelltokenize' # for TextMate::selected_paths_array

module Subversion
  def Subversion.diff_active_file( revision, command )
    svn         = ENV['TM_SVN'] || 'svn'
    diff_cmd    = ENV['TM_SVN_DIFF_CMD']
    diff_arg    = diff_cmd ? "--diff-cmd #{diff_cmd}" : ''
#   target_path = ENV['TM_FILEPATH']

    error       = ""
    result      = ""

    TextMate::call_with_progress(:title => command, :message => "Accessing Subversion Repository…") do
      TextMate::selected_paths_array.each do |target_path|
        svn_header  = /\AIndex: #{Regexp.escape(target_path)}\n=+\n\z/
        res = %x{"#{svn}" 2>&1 diff "-r#{revision}" #{diff_arg} "#{target_path}"}

        if $? != 0
          # The command failed; show its output as a tooltip
          error << res
        elsif (custom_diff? or diff_cmd) and res =~ svn_header
          # Suppress output, as we only got a svn header (so likely diff-cmd opened its own window)
        else
          result << res
        end
      end

      TextMate::exit_show_tool_tip(error)                     unless error.empty?
      TextMate::exit_show_tool_tip("No differences found.")   if result.empty?
      puts result
    end
  end

  # Returns true if ~/.subversion/config contains an uncommented entry for diff-cmd
  def Subversion.custom_diff?
    config_file = ENV['HOME'] + "/.subversion/config"
      
    if File.exists?(config_file)
      IO.foreach(config_file) do |line|
        return true if line =~ /^\s?diff-cmd\s?=\s?(.*)/
      end
    end
    
    return false
  end  
end
