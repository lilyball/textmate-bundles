#!/usr/bin/env ruby  

require "#{ENV['TM_SUPPORT_PATH']}/lib/textmate"
require "erb"
require "pp"
include ERB::Util

class ExList
  def initialize
    @values = []
  end
  def contains(test)
    found = true
    @values.each do |item|
      if test == item.chomp
        found = false
      end
    end
    return found
  end
  def add(item)
    @values.push item
  end
  def print
    puts @values
  end
end

def printTasks

  $myPath = ENV['TM_DIRECTORY'] 
  $tags = [] #user defined contexts
  
  def readContexts(a)
    # processes contexts.gtd into script  
    context, tabCommand, tabString, regex, color = a.split(/\|/)
    if $exceptions == "some"
      if  (context[0..2] != "+  ")
        $tags.push({:label => context[3..-1], :regexp => regex, :color => color, :matches => []}) 
      end 
    elsif  $exceptions == "full"
      if  ((context[0..2] != "<- ") && (context[0..2] != "-> ") && (context[0..2] != "+  "))
        $tags.push({:label => context[3..-1], :regexp => regex, :color => color, :matches => []}) 
      end
    else    
      $tags.push({:label => context[3..-1], :regexp => regex, :color => color, :matches => []})   
    end
  end
  
  
  def TextMate.file_link (file, line = 0)
    return "txmt://open/?url=file://" + $myPath + "/" +
      file.gsub(/[^a-zA-Z0-9.-\/]/) { |m| sprintf("%%%02X", m[0]) } +
      ".gtd&amp;line=" + line.to_s
  end 
  
  # the contexts.gtd file is read, and converted into $contexts
  file = File.open($myPath+"/contexts.gtd", "r")
  file.each do |line|
    readContexts(line)
  end 

  xFile = File.open($myPath+"/excluded.gtd", "r")

  myList = ExList.new

  xFile.each do |line|
    myList.add(line)
  end

  # sorting happens
  $todoList = ""
  $tags.each do |tag| 
    context = tag[:regexp]
    matches = 0
    #puts context
    myFiles = Dir.entries($myPath)
    myFiles.each do |fileName|
      if ((fileName[-3,3] == "gtd") and myList.contains(fileName))
        lineno = 0
        mFile = File.open(fileName) 
        mFile.each do |line|
          lineno = lineno + 1
          tLine = line[3..-1]
          if tLine != nil
            re = /\s/
            if (line[0..1] == "- " or line[0..1] == "! ")
              ctask = re.match(tLine)
            else 
              ctask = re.match(line)
            end
            if (ctask.pre_match == context)
              results = {
                :file => fileName[0..-5],
                :line => lineno,
                :content => ctask.post_match    
              }
              tag[:matches] << results
              $todoList += results.to_s
              matches += 1
              if matches == 1
                $todoList += tag[:label] + "\n"
              end
            end
  	      end     
        end
        if matches == 0
          # todoList += "none\n"
        end
        $todoList += "\n"
      end
    end
  end
  if $exceptions == "some"
    File.open($myPath + "/todoList.txt", "w") {|f|
      f << $todoList}
  else
    tmpl_file = "#{ENV['TM_BUNDLE_SUPPORT']}/template.rhtml"
    puts ERB.new(File.open(tmpl_file), 0, '<>').result
  end
end  

def displayTasks
  $exceptions = "full"
  printTasks
end

def displaySomeTasks
  $exceptions = "some"
  printTasks
end

def displayAllTasks
  $exceptions = false
  printTasks
end


