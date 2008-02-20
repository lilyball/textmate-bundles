#!/usr/bin/env ruby

def snippet_generator(cand, start)

  cand = cand.strip
  oldstuff = cand[0..-1].split("\t")
  stuff = cand[start..-1].split("\t")
  stuffSize = stuff[0].size
  if oldstuff[0].count(":") == 1
    out = "${0:#{stuff[6]}}"
  elsif oldstuff[0].count(":") > 1

    name_array = stuff[0].split(":")
    name_array = [""] if name_array.empty?
    out = ""
    begin
      stuff[-(name_array.size)..-1].each_with_index do |arg,i|

        if (name_array.size == i)
            out << name_array[i] + ":${0:"+(i+2).to_s + ":"+ arg +"} "
        else

          out << name_array[i] +  ":${"+(i+2).to_s + ":"+ arg +"} "
        end
      end
      out = "${1:#{stuff[6]}} " + out
      
    rescue NoMethodError
      out = "$0"
    end
    
  else
    out = "$0"
  end
  #puts out.inspect
  return out.chomp.strip
end

def cfunction_snippet_generator(c)
  c = c.split"\t"
  i = 0
  "("+c[1][1..-2].split(",").collect do |arg| 
    "${"+(i+=1).to_s+":"+ arg.strip + "}" 
  end.join(", ")+")$0"
end


require "/Library/Application Support/TextMate/Support/lib/osx/plist"
s = STDIN.read
res = OSX::PropertyList::load(s)

if res['type'] == "methods"
  r = snippet_generator(res['cand'], res['filterOn'].size)
elsif res['type'] == "functions"
  r = cfunction_snippet_generator(res['cand'])
else 
  r = "$0"
end

print r