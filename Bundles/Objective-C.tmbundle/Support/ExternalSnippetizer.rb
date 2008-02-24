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

def construct_arg_name(arg)
  a = arg.match(/(NS|AB|CI|CD)?(Mutable)?(([AEIOQUYi])?[A-Za-z_0-9]+)/)
  unless a.nil?
    (a[4].nil? ? "a": "an") + a[3].sub!(/\b\w/) { $&.upcase }
  else
    ""
  end
end

def type_declaration_snippet_generator(dict)
  
  arg_name = dict['extraOptions']['arg_name'] == "true" && dict['noArg'] == "false"
  star = dict['extraOptions']['star'] == "true" && dict['pure'] == "false"
  pointer = dict['environment']['TM_C_POINTER']
  pointer = " *" unless pointer
  
  if arg_name
    name = "${2:#{construct_arg_name dict['filterOn']}}"
    if star
      name = ("${1:#{pointer}#{name}}")
    else
      name = " " + name
    end

  else
    name = pointer.rstrip if star
  end
  #  name = name[0..-2].rstrip unless arg_name
  name + "$0"
end

def cfunction_snippet_generator(c)
  c = c.split"\t"
  i = 0
  "("+c[1][1..-2].split(",").collect do |arg| 
    "${"+(i+=1).to_s+":"+ arg.strip + "}" 
  end.join(", ")+")$0"
end

s = STDIN.read
res = OSX::PropertyList::load(s)
#puts res.inspect.gsub("\",", "\",\n")

if res['type'] == "methods"
  r = snippet_generator(res['cand'], res['filterOn'].size)
elsif res['type'] == "functions"
  r = cfunction_snippet_generator(res['cand'])
elsif res['pure'] && res['noArg']
  r = type_declaration_snippet_generator res
else 
  r = "$0"
end

print r