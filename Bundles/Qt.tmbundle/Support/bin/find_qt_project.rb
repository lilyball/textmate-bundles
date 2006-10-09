#!/usr/bin/env ruby
# Based on find_xcode_project.rb by Chris Thomas.
require 'pathname'

class QtProjectSearch

private
  # FIXME Assumes the directory only contains one Qt project
  def self.project_in_dir(path)
    entries = Dir.entries(path)

    project = entries.detect {|entry| entry =~ /.pro$/}

    project ? path + "/" + project : nil
  end

  def self.project_by_walking_up( start_dir = Dir.pwd )
    project     = nil
    save_dir    = start_dir
    current_dir = save_dir

    Dir.chdir( current_dir )
    begin
      until current_dir == '/'
        project = project_in_dir(current_dir)
        break unless project.nil?

        Dir.chdir '..'
        current_dir = Dir.pwd
      end
    ensure
      Dir.chdir(save_dir)
    end

    project
  end

public
  def self.find_project
    qt_project          = ENV['TM_QT_PROJECT']
    active_file_dir     = ENV['TM_DIRECTORY']
    active_project_dir  = ENV['TM_PROJECT_DIRECTORY']

    # Allow paths relative to TM_PROJECT_DIRECTORY
    if qt_project && !qt_project[%r{^/}]
      qt_project = active_project_dir + "/" + qt_project
    end

    # user-specified TM_QT_PROJECT overrides everything else
    if (qt_project.nil?) or (qt_project.empty?)

      # If we didn't find an qt project in the project directoy, search from current dir and upwards
      if (qt_project.nil?) or (qt_project.empty?)
        qt_project = project_by_walking_up(active_file_dir)
      end

      # If we have an open file in a saved project (or a scratch project)
      if ((qt_project.nil?) or (qt_project.empty?)) and 
         ((not active_project_dir.nil?) and (not active_project_dir.empty?))
        qt_project = project_in_dir(active_project_dir)
      end

    end

    if qt_project.nil? or qt_project.empty?
      raise "Didn't find a Qt project file.\nYou may want to set TM_QT_PROJECT."
    end

    qt_project
  end
end

#
# if this file is executed as a shell command (i.e. not serving as a Ruby library via require),
# print the file name and cd to the parent directory of the Qt project so that make
# works properly.
#
if __FILE__ == $0
  begin
	  project = QtProjectSearch.find_project
    Dir.chdir File.dirname(project)
    puts project
  rescue Exception => e
    puts e.message
  end
end
