#!/usr/bin/env ruby

# for the time being treetop and polyglot needs to be gem installed
require "rubygems"
require "treetop"
require "#{ENV['TM_SUPPORT_PATH']}/lib/ui"
require ENV['TM_SUPPORT_PATH'] + "/lib/exit_codes"
require "#{ENV['TM_SUPPORT_PATH']}/lib/escape"



class ExternalSnippetizer
  def snippet_generator(cand, start)

    cand = cand.strip
    oldstuff = cand[0..-1].split("\t")
    stuff = cand[start..-1].split("\t")
    stuffSize = stuff[0].size
    if oldstuff[0].count(":") == 1
      out = "${0:#{stuff[6]}}"
    elsif oldstuff[0].count(":") > 1

      name_array = stuff[0].split(":")
      out = "${1:#{stuff[-name_array.size - 1]}} "
      unless name_array.empty?
        begin      
          stuff[-(name_array.size)..-1].each_with_index do |arg,i|
            out << name_array[i] +  ":${"+(i+2).to_s + ":"+ arg +"} "
          end
        rescue NoMethodError
          out = "$0"
        end
      end
    else
      out = "$0"
    end
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

    arg_name = dict['extraOptions']['arg_name'] && dict['noArg']
    star = dict['extraOptions']['star'] && dict['pure']
    pointer = dict['environment']['TM_C_POINTER']
    pointer = " *" unless pointer

    if arg_name
      name = "${2:#{construct_arg_name dict['match']}}"
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

  def run(res, len = 0)
    if res['type'] == "methods"
      r = snippet_generator(res['cand'], res['match'].size)
    elsif res['type'] == "functions"
      r = cfunction_snippet_generator(res['cand'])
    elsif res['pure'] && res['noArg']
      r = type_declaration_snippet_generator res
    else 
      r = "$0"
    end
    return r
  end
end



class CppMethodCompletion
  #require "#{ENV['TM_BUNDLE_SUPPORT']}/cpp_parser"
  Treetop.load "#{ENV['TM_BUNDLE_SUPPORT']}/cpp_parser"
  

def initialize(line)
  @line = line
  @parser = CppParser.new
  @std = {
      "std::map" => { :methods => { "begin" =>[{ :r => "std::map::iterator", :a => "()"}],
      "clear" =>[{ :r => "void", :a => "()"}],
      "count" =>[{ :r => "size_type", :a => "( const key_type& key )"}],
      "empty" =>[{ :r => "bool", :a => "()"}],
      "end" =>[{ :r => "std::map::iterator", :a => "()"}],
      "equal_range"=>[{:r=>"std::pair<iterator,iterator>",:a=>"( const key_type& key )"}],
      "erase" =>[{ :r => "void", :a => "( iterator pos )"},{ :r => "void", :a => "( iterator start, iterator end )"},{ :r => "size_type", :a => "( const key_type& key )"}],
      "find" =>[{ :r => "std::map::iterator", :a => "( const key_type& key )"}],
      "insert" =>[{ :r => "std::map::iterator", :a => "( iterator i, const TYPE& pair )"},{ :r => "void", :a => "( input_iterator start, input_iterator end )"},{ :r => "std::pair<iterator,bool>", :a => "( const TYPE& pair )"}],
      "key_comp" =>[{ :r => "key_compare", :a => "()"}],
      "lower_bound" =>[{ :r => "std::map::iterator", :a => "( const key_type& key )"}],
      "max_size" =>[{ :r => "size_type", :a => "()"}],
      "rbegin" =>[{ :r => "std::map::iterator", :a => "()"}],
      "rend" =>[{ :r => "std::map::iterator", :a => "()"}],
      "size" =>[{ :r => "size_type", :a => "()"}],
      "swap" =>[{ :r => "void", :a => "( container& from )"}],
      "upper_bound" =>[{ :r => "std::map::iterator", :a => "( const key_type& key )"}],
      "value_comp" =>[{ :r => "value_compare", :a => "()"}],
                                        }
                    },
"std::pair<iterator,bool>" => {:methods=>{"first"=>[{:a=>"",:r=>"std::map::iterator"}],
                                              "second"=>[{:a=>"",:r=>"bool"}]
                                             }
                                  },
"std::pair<iterator,iterator>" => {:methods=>{"first"=>[{:a=>"",:r=>"std::map::iterator"}],
                                                                                "second"=>[{:a=>"",:r=>"std::map::iterator"}]
                                                                               }
                                                                    },
    "std::vector" => {:methods => { "assign" =>[{ :r => "void", :a => "( size_type num, const TYPE& val )"},{ :r => "void", :a => "( input_iterator start, input_iterator end )"}],
                    "at" =>[{ :r => 1, :a => "( size_type loc )"}],
                    "back" =>[{ :r => 1, :a => "()"}],
                    "begin" =>[{ :r => "std::vector::iterator", :a => "()"}],
                    "capacity" =>[{ :r => "size_type", :a => "()"}],
                    "clear" =>[{ :r => "void", :a => "()"}],
                    "empty" =>[{ :r => "bool", :a => "()"}],
                    "end" =>[{ :r => "std::vector::iterator", :a => "()"}],
                    "erase" =>[{ :r => "std::vector::iterator", :a => "( iterator loc )"},{ :r => "std::vector::iterator", :a => "( iterator start, iterator end )"}],
                    "front" =>[{ :r => 1, :a => "()"}],
                    "insert" =>[{ :r => "std::vector::iterator", :a => "( iterator loc, const TYPE& val )"},{ :r => "void", :a => "( iterator loc, size_type num, const TYPE& val )"}],
                    "insert" =>[{ :r => "void", :a => "( iterator loc, input_iterator start, input_iterator end )"}],
                    "max_size" =>[{ :r => "size_type", :a => "()"}],
                    "pop_back" =>[{ :r => "void", :a => "()"}],
                    "push_back" =>[{ :r => "void", :a => "( const TYPE& val )"}],
                    "rbegin" =>[{ :r => "std::vector::iterator", :a => "()"}],
                    "rend" =>[{ :r => "std::vector::iterator", :a => "()"},],
                    "reserve" =>[{ :r => "void", :a => "( size_type size )"}],
                    "resize" =>[{ :r => "void", :a => "( size_type num, const TYPE& val = TYPE() )"}],
                    "size" =>[{ :r => "size_type", :a => "()"}],
                    "swap" =>[{ :r => "void", :a => "( container& from )"}],
                                  }
                     },
    "std::vector::iterator" => {:methods =>{"->" => [{:a =>"",:r=>1}] }},
    "std::map::iterator" => {:methods=>{"->" =>[{:a => "", :r=>"std::pair"}]}},
    "std::pair" =>{:methods=>{"first"=>[{:a=>"",:r=>1}],
                              "second"=>[{:a=>"",:r=>2}]
                             }
                  },

    "a" => {:methods => {"methodA1"=>[{:a=>"()",:r => "b"}], 
                         "methodA2"=>[{:a=>"()",:r => "c"}]}},
    "b" => {:methods => {"methodB1"=>[{:a=>"()",:r => "a"}], 
                         "methodB2"=>[{:a=>"()",:r => "c"}]}},
    "c" => {:methods => {"methodC1"=>[{:a=>"()",:r => "a"}], 
                         "methodC2"=>[{:a=>"()",:r => "b"}]}},
  }
end

def lookupClass(name)
  @std[name]
end

def updateClass(res, initial)
  previousClass = res[0][:r]
  if previousClass.class.inspect == "Fixnum"
    initial = initial[previousClass]
    if initial.nil?
      TextMate.exit_show_tool_tip "could not find type info for the dereferenced object, template arg ##{previousClass} missing"
    end
    previousClass = lookupClass(initial[:type])
  elsif previousClass.class.inspect == "String"
    previousClass = lookupClass(previousClass)
  end
  return previousClass, initial
end

def complete(item, previousClass)
  suggestions = []
  mat = (/^#{item[:prefix]}./)
  previousClass[:methods].each do |key, value|
    if key =~ mat
      value.each do |item|
        suggestions << { 'display' => key + item[:a], 'cand' => key+"\t"+item[:a], 'match'=> key, 'type'=> "functions"}
      end
    end
  end
  flags = {}
  flags[:extra_chars]= '_'
  flags[:initial_filter]= item[:prefix]
  begin
    TextMate::UI.complete(suggestions, flags) do |hash|
      ExternalSnippetizer.new.run(hash)
    end
  rescue NoMethodError
    TextMate.exit_show_tool_tip "you have Dialog2 installed but not the ui.rb in review"
  end
  TextMate.exit_discard
end
$t = true
def po s
  TextMate.exit_show_tool_tip s
end

  def rightMostClass(type_chain, res)
  first = type_chain.shift

  #po first.inspect + type_chain.inspect + res.inspect.gsub(',',",\n")
  #$t = false
  if first[:kind] == :field
    initial = res[first[:name]]
    #TextMate.exit_create_new_document res.inspect
    po("could not find type of '#{first[:name]}'") if initial.nil?
    if initial[:type]
      previousClass = lookupClass(initial[:type])
    else
      iterate = initial[:iterator]
      dref = initial[:dref]
      #po initial.inspect
      initial = rightMostClass(initial[:type_of],res)
      initial = initial[1] if dref
      name = initial[:type] + (iterate ? "::iterator" : "")
      # add the resolved var to the global list
      h = initial.dup
      h[:type] = name
      res[first[:name]] = h
      previousClass = lookupClass(name)
    end

   # po previousClass.inspect.gsub(',',",\n") if $t
   # $t = false
   po "could not find '#{name}'" if previousClass.nil?
    if first[:bind] == "->" && previousClass[:methods]["->"]
      previousClass, initial = updateClass(previousClass[:methods]["->"], initial)
    end
  elsif
    TextMate.exit_show_tool_tip "completing with a method as base is currently not supported"
  end  
  type_chain.each do |item|
    if item[:name]
      if item[:kind] == :method || item[:kind] == :field
        r =previousClass[:methods][item[:name]]
        unless r.nil?          
          r1 = lookupClass( r[0][:r] )
          if r1 && item[:bind] == "->" && r1[:methods]["->"]
            # the only classes that are allowed to have -> are defined in std
            # along with what they return
            
            previousClass, initial = updateClass(r1[:methods]["->"], initial)           
          elsif r
            previousClass, initial = updateClass(r, initial)
          else
            puts "strange"
          end
        else
          # Trying to find a method with the correct name in the correct class failed
          # here it would be handy if we could look up any methodname declared
          # regardless of class belonging
        end

      end
    elsif item[:prefix]
      if previousClass.nil?
        TextMate.exit_show_tool_tip "No completion found"
      else
        complete(item, previousClass)
      end
    end
  end
  return initial
  
end

def print()
  #TextMate.exit_show_tool_tip @line
  a = @parser.parse(@line)
  TextMate.exit_discard if a.nil?
  res = a.types
  type_chain = res[:current_type]
  TextMate.exit_discard if type_chain.nil?
  #special treatment for first element since we do not know what class we are in
  rightMostClass(type_chain, res)

end

end
#{:current_type=>[{:name=>"map", :kind=>:field, :bind=>"."},
#                 {:name=>"begin", :kind=>:method, :bind=>"->"},
#                 {:name=>"second", :kind=>:field, :bind=>"."},
#                 {:prefix=>"met"}]
# "map"=>{:type=>"std::map", 1=>{:type=>"std::vector", 1=>{:type=>"a"}}, 2=>{:type=>"b"}}}