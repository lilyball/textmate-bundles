#!/usr/bin/env ruby
# run with find /System/Library/Frameworks/*.framework -name \*.h | ruby generateMethodList.rb
translate = {"Message" => "Me",
"AddressBook" => "AB",
"SecurityFoundation" => "SF",
"QTKit" => "QT",
"IOBluetooth" => "Blue",
"WebKit" => "WK",
"SenTestingKit" => "Test",
"InstallerPlugins" => "Ins",
"CoreData" => "CD",
"Carbon" => "Ca",
"Automator" => "Au",
"SyncServices" => "Sync",
"AppKit" => "AK",
"InterfaceBuilder" => "IB",
"InstantMessage" => "IM",
"DiscRecording" => "DR",
"AppleScriptKit" => "ASK",
"SecurityInterface" => "SI",
"OSAKit" => "OSA",
"QuartzCore" => "CI",
"Foundation" => "F",
"AudioUnit" => "AU",
"ScreenSaver" => "Sav",
"Quartz" => "Q",
"PreferencePanes" => "Pref",
"ExceptionHandling" => "Exc",
"DiscRecordingUI" => "DRui",
"CoreAudioKit" => "CAK",
"XgridFoundation" => "Grid",
"IOBluetoothUI" => "BUI"}
require 'optparse'

  options = {}
  OptionParser.new do |opts|
    opts.banner = "Usage: example.rb [options]"

    opts.on("-c", "--classOutput FILENAME", "Run verbosely") do |v|
      options[:class] = v
    end
    opts.on("-m", "--methodOutput FILENAME", "Run verbosely") do |v|
      options[:method] = v
    end
  end.parse!

def method_parse(k)
  l = k.scan /(\-|\+)\s*\((([^\(\)]|\([^\)]*\))*)\)|\((([^\(\)]|\([^\)]*\))*)\)\s*[a-zA-Z][a-zA-Z0-9]*|(([a-zA-Z][a-zA-Z0-9]*)?:)/
  types = l.select {|item| item[1] || item[3] }.collect{|item| (item[1] || item[3]).gsub(/(\w)\*/,'\1 *') }

  methodList = l.reject {|item| item[5].nil? }.collect{|item| item[5] }
  if methodList.size > 0
    methodName = methodList.join
  elsif mn = k.match(/\)\s*([a-zA-Z][a-zA-Z0-9]*)/)
    methodName = mn[1]
  else
    methodName = k.match(/([a-zA-Z][a-zA-Z0-9]*)/)[1]
  end  
  [methodName, types]
  
end
#headers = %x{find /System/Library/Frameworks/*.framework -name \*.h}.split("\n")
headers = STDIN.read.split("\n")
#headers = ["test.h"]
rgxp = /^((@interface)|(@end)|((\-|\+)\s*\()|((\-|\+)[^;]*\;)|(@protocol[^\n;]*\n))/
list = []
classList = []
headers.each do |name|
  if mat = name.match(/(\w*)\.framework/)
    framework = mat[1]
  else
    framework = "Priv"
  end
  filename = name.match(/(\w*)\.h/)[1]
  unless framework == "JavaVM"
  open(name) do |file|
    str = file.read
    while m = str.match(rgxp)
      str = m[0] + m.post_match
      if m[2]
        k = str.match /@interface(?:\s|\n)+(\w+)[^\n]*/
        if k
          methodType = "dm" if k[0].match /\(\s*\w*[Dd]elegate\w*\s*\)/
          className = k[1]
          if translate[framework]
            frameworkName = translate[framework]
          else
            frameworkName = "NA"
          end
          classList << "#{className}"
          classType = "Cl"
          inClass = true
          
          str = k.post_match
        else
          str = m.post_match
        end
      elsif m[3]
        inClass = false
        str = m.post_match
      elsif m[4]
        k = str.match /[^;{]+?(;|\{)/
        if inClass
          methodName, types = method_parse(k[0])
          na = className
          na += ";#{filename}" unless className == filename
          methodType = {"+" => "cm", "-" => "im"}[m[5]] unless methodType == "dm"
          if translate[framework]
             frameworkName = translate[framework]
           else
             frameworkName = "NA"
           end
          list << "#{methodName}\t#{frameworkName}\t#{classType}\t#{na}\t#{methodType}\t#{types.join("\t")}"
        end
        str = k.post_match

      elsif m[6]
        if inClass
          methodName, t = method_parse(m[6])
          types = ["id"]
          types += t if t.size > 0
          na = className
          na += ";#{filename}" unless className == filename
          methodType = {"+" => "cm", "-" => "im"}[m[7]] unless methodType == "dm"
          if translate[framework]
             frameworkName = translate[framework]
          else
             frameworkName = "NA"
          end
            
          list << "#{methodName}\t#{frameworkName}\t#{classType}\t#{na}\t#{methodType}\t#{types.join("\t")}"
        end
        str = m.post_match
      elsif m[8]
        k = str.match /@protocol\s+(\w+)[^\n]*/
        if k
          className = k[1]
          classType = "Pr"
          inClass = true
          str = k.post_match
        end
      else
        str = m.post_match
      end
    end
  end
end
end
if options.empty?
  print list.join("\n")
else
  File.open(options[:class],"w")do |f| f.write(classList.uniq.join("\n")) end unless options[:class].nil?
  File.open(options[:method],"w")do |f| f.write(list.join("\n")) end unless options[:method].nil?
end
p options
#netService:didNotPublish:	F	Cl	NSNetService;NSNetServices	dm	void	NSNetService *	NSDictionary *
#begin = '((:))\s*(\()';
#					end = '(\))\s*(\w+\b)?';