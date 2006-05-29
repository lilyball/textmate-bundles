#!/usr/bin/env ruby -w

$LOAD_PATH << ENV['TM_SUPPORT_PATH'] + "/lib"
require 'progress'

module Subversion
  def Subversion.diff_active_file( revision, command )
    svn         = ENV['TM_SVN'] || 'svn'
    diff_cmd    = ENV['TM_SVN_DIFF_CMD']
    diff_arg    = diff_cmd ? "--diff-cmd #{diff_cmd}" : ''

    target_path = ENV['TM_FILEPATH']
    svn_header  = /\AIndex: #{Regexp.escape(target_path)}\n=+\n\z/

    TextMate::call_with_progress(:title => command, :message => "Accessing Subversion Repository…") do
      res = %x{"#{svn}" 2>&1 diff "-r#{revision}" #{diff_arg} "#{target_path}"}

      if $? != 0
        print res
        exit 206      # The command failed; show its output as a tooltip
      elsif res.empty?
        puts "No differences found."
        exit 206      # Report lack of differences as a tooltip
      elsif (custom_diff? or diff_cmd) and res =~ svn_header
        exit 200      # Suppress output, as we only got a svn header (so likely diff-cmd opened its own window)
      else
        print res
      end
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
