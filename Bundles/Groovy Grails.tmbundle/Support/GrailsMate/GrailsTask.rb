#!/usr/bin/env ruby -w

require "#{ENV["TM_SUPPORT_PATH"]}/lib/escape"

class GrailsTask
  
  def initialize(task = nil, *options)
    @mode = :line_by_line
    build_grails_command(task, *options)
  end
  
  def run(&block)
    open(@command) do | grails_task |
      if block.nil?
        grails_task.read
      else
        loop do
          break if grails_task.eof?
          new_content = (@mode == :char_by_char) ? grails_task.getc.chr : grails_task.gets
          @mode = (block.arity == 2) ? block[new_content, @mode] : block[new_content]
        end
      end
    end
  end
  
  private
  
  def build_grails_command(task, *options)
    @command =  "|"
    @command << " " << task unless task.nil?
    unless options.empty?
      @command << " " << options.map { |arg| e_sh(arg) }.join(" ")
    end
    @command << " 2>&1"
  end
  
end
