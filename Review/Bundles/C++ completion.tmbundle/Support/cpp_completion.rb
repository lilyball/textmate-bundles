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
            out << name_array[i] +  ":${"+(i+2).to_s + ":"+ arg + "} "
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
  attr_accessor :res_hier

  def initialize(line)
    @line = line
    @scopes = nil
    @parser = CppParser.new
#    @std = {
#      :namespace => { "std" =>{ :classes => {
#    "map" => {:classes => {"iterator" => {:methods=>{"->" =>[{:a => "", :type=>"std::pair"}]}},},
#       :methods => { "begin" =>[{ :type => "std::map::iterator", :a => "()"}],}}}}}}
#    
    @std = {
      :namespace => { "std" =>{ :classes => {
    "map" => { :methods => { 
        "begin" =>[{ :type => "std::map::iterator", :a => "()"}],
        "clear" =>[{ :type => "void", :a => "()"}],
        "count" =>[{ :type => "size_type", :a => "( const key_type& key )"}],
        "empty" =>[{ :type => "bool", :a => "()"}],
        "end" =>[{ :type => "std::map::iterator", :a => "()"}],
        "equal_range"=>[{:type=>"std::pair", #<iterator,iterator>",
                         :a=>"( const key_type& key )",
                         :t=>{ 1=>{:type=>"std::map::iterator", :t=>{1=>1,2=>2}
                                  }, 
                               2=>{:type=>"std::map::iterator", :t=>{1=>1,2=>2}
                                  }
                              }
                        }],
        "erase" =>[{ :type => "void", :a => "( iterator pos )"},{ :type => "void", :a => "( iterator start, iterator end )"},{ :type => "size_type", :a => "( const key_type& key )"}],
        "find" =>[{ :type => "std::map::iterator", :a => "( const key_type& key )"}],
        "insert" =>[{ :type => "std::map::iterator", :a => "( iterator i, const TYPE& pair )"},{ :type => "void", :a => "( input_iterator start, input_iterator end )"},
          { :type => "std::pair",
            :a => "( const TYPE& pair )",
            :t => {1=>{:type=>"std::map::iterator", :t=>{1=>1,2=>2}},
                   2=>{:type=>"bool"}  }}],
        "key_comp" =>[{ :type => "key_compare", :a => "()"}],
        "lower_bound" =>[{ :type => "std::map::iterator", :a => "( const key_type& key )"}],
        "max_size" =>[{ :type => "size_type", :a => "()"}],
        "rbegin" =>[{ :type => "std::map::iterator", :a => "()"}],
        "rend" =>[{ :type => "std::map::iterator", :a => "()"}],
        "size" =>[{ :type => "size_type", :a => "()"}],
        "swap" =>[{ :type => "void", :a => "( container& from )"}],
        "upper_bound" =>[{ :type => "std::map::iterator", :a => "( const key_type& key )"}],
        "value_comp" =>[{ :type => "value_compare", :a => "()"}],
        },
        :classes => {"iterator" => {:methods=>{"->" =>[{:a => "", :type=>"std::pair"}]}},}
    },
    
    "vector" => {:methods => { 
      "assign" =>[{ :type => "void", :a => "( size_type num, const TYPE& val )"},
                  { :type => "void", :a => "( input_iterator start, input_iterator end )"}],
      "at" =>[{ :type => 1, :a => "( size_type loc )"}],
      "back" =>[{ :type => 1, :a => "()"}],
      "begin" =>[{ :type => "std::vector::iterator", :a => "()"}],
      "capacity" =>[{ :type => "size_type", :a => "()"}],
      "clear" =>[{ :type => "void", :a => "()"}],
      "empty" =>[{ :type => "bool", :a => "()"}],
      "end" =>[{ :type => "std::vector::iterator", :a => "()"}],
      "erase" =>[{ :type => "std::vector::iterator", :a => "( iterator loc )"},
         { :type => "std::vector::iterator", :a => "( iterator start, iterator end )"}],
      "front" =>[{ :type => 1, :a => "()"}],
      "insert" =>[{ :type => "std::vector::iterator",
                    :a => "( iterator loc, const TYPE& val )"},
        { :type => "void", :a => "( iterator loc, size_type num, const TYPE& val )"}],
      "insert" =>[{ :type => "void", 
                    :a => "( iterator loc, input_iterator start, input_iterator end )"}],
      "max_size" =>[{ :type => "size_type", :a => "()"}],
      "pop_back" =>[{ :type => "void", :a => "()"}],
      "push_back" =>[{ :type => "void", :a => "( const TYPE& val )"}],
      "rbegin" =>[{ :type => "std::vector::iterator", :a => "()"}],
      "rend" =>[{ :type => "std::vector::iterator", :a => "()"},],
      "reserve" =>[{ :type => "void", :a => "( size_type size )"}],
      "resize" =>[{ :type => "void", :a => "( size_type num, const TYPE& val = TYPE() )"}],
      "size" =>[{ :type => "size_type", :a => "()"}],
      "swap" =>[{ :type => "void", :a => "( container& from )"}],
                                    },
      :classes => {"iterator" => {:methods =>{"->" => [{:a =>"",:type=>1}] }},},
                       },
      "pair" =>{:methods=>{"first"=>[{:a=>"",:type=>1}],
                           "second"=>[{:a=>"",:type=>2}]
                                          }
                               },
                             },},},
   :classes => {
      "a" => {:methods => {"methodA1"=>[{:a=>"()",:type => "b"}], 
                           "methodA2"=>[{:a=>"()",:type => "c"}]}},
      "b" => {:methods => {"methodB1"=>[{:a=>"()",:type => "a"}], 
                           "methodB2"=>[{:a=>"()",:type => "c"}]}},
      "c" => {:methods => {"methodC1"=>[{:a=>"()",:type => "a"}], 
                           "methodC2"=>[{:a=>"()",:type => "b"}]}},
                         },
    }
  end
  
  
  def complete(item, scope, qualifier)
    symbolDict = lookupList(item, scope, qualifier)
    suggestions = []
    
    mat = (/^#{item[:prefix]}./)
    symbolDict.each do |key, value|
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
  
  def po s
    TextMate.exit_show_tool_tip s
  end
  
  def pd s
    TextMate.exit_create_new_document s
  end
  
  def updateTemplate(variableT, returnType )
    returnType.each do |key, value|
      if value.kind_of? Hash
        updateTemplate(returnType, variableT)
      elsif value.kind_of? Integer
        returnType[key] = variableT[value]
      end
    end
  end
  
  def traverse(scope, tableRoot, lookIn)
    return tableRoot, nil if scope.empty?
    lookInUsed = nil
    
    r = scope.inject(tableRoot) do |result, element|
      res = nil
      lookIn.each do |e|
        lookInUsed = e
        res = result[e][element] if result[e]
        break unless res.nil?
      end
      if res.nil?
        lookInUsed = nil
        break
      end
      
      res
    end
    return r, lookInUsed
  end
  
  def lookupTHelp(hierachy, scope, qualifier, verify_presence_of)
    scopeCopy = scope.dup
    default = [:namespace, :classes]
    qualiferDefault = [:namespace, :classes, :typedefs]
    hierachy.reverse_each do |lib|
      (scope.length + 1 ).times do |i|
        #pd hierachy.inspect + "empty.>" if lib.empty?
        if qualifier.first && qualifier.first.empty?
          r, k = traverse(qualifier, lib, qualiferDefault)
        else
          r, k = traverse(scope, lib, default)
          r, k = traverse(qualifier, r, qualiferDefault) unless r.nil?
         
        end
        #k = traverse(verify_presence_of, r)
        if k == :typedefs
          qualifier.replace(r[:type].split("::"))
          retry
        end

        r = verify_presence_of.inject(r) do |result, elem|
          break if result.nil?
          result[elem]
        end

        return r if r
        scope.pop
      end
      scope = scopeCopy.dup
    end 
    nil
  end
  
  
  
  def lookup(scope, qualifier, verify_presence_of)
    original = scope.dup
    returnT = nil
    std_hier = @std
    user_hier = {}
    hierachy = [std_hier, user_hier]
    if scope.last == "#localScope"
     hierachy << res_hier
    end
    returnT = lookupTHelp(hierachy, scope, qualifier, verify_presence_of)
    if returnT.nil?
      #return returnT
      po "could not look up '#{qualifier.join("::")}' in scope '#{original.join("::")}'"
    else
      return returnT
    end
  end
  
  def dereference(variableT, item, currentScope)
    vtp = variableT[:pointers] || 0
    ip = item[:pointers] || 0
    if ip >= vtp
      return false
    else
      val = lookupT(variableT, currentScope)
      unless val.nil?
        updateTemplate(variableT, val)
        return true
      end
    end
  end
  
  def updateScope(variableT, currentScope)
  end
  
  def lookupT(item, scope, qualifier)
    r = lookup(scope, qualifier, [item[:kind], item[:name]])
    return r[0] if item[:kind] == :methods
    return r
  end
  
  def lookupList(item, scope, qualifier)
    r = lookup(scope, qualifier, [:methods])
    if r.nil?
      po "could not find symbols starting with #{item[:prefix]}"
    end
    
    return r
  end

  def returnTypeHandling(returnType, templates, qualifier)
    value = returnType[:type]
    if value.kind_of? Numeric
      returnType = templates[value].dup
      returnTypeHandling(returnType, templates, qualifier)
    elsif value.kind_of? Hash
      updateTemplate(variableT, returnType)
    else
      qualifier.replace value.split("::")
    end
  end

  def rightMostClass(type_chain, currentScope, qualifier)
    originalScope = currentScope.dup
    if type_chain.first[:name] == "this"
      qualifier.pop
    end
    templates = {}
    
    type_chain.each do |item|
      # item[:name] = "at"
      if item[:name]
        # scope = rubinius::Array::#localScope
        returnType = lookupT(item, currentScope, qualifier)
        templates = returnType[:t] if returnType[:t]
        returnTypeHandling(returnType,templates, qualifier)

      elsif item[:prefix]
        if qualifier.nil?
          TextMate.exit_show_tool_tip "No completion found"
        else

          complete(item, currentScope, qualifier)
        end
      end
    end
    return currentTemplateArgs
  end

def print()
  #TextMate.exit_show_tool_tip @line
  a = @parser.parse(@line)
  TextMate.exit_discard if a.nil?
  qualifier = [] 
  namespace = ["namespace", "className", "#localScope" ]
  temp = a.types
  @res_hier = {}
  k = namespace.inject(@res_hier) do |result, elem|
    a = {}
    result[:classes] = { elem => a}
    a
  end
  k.replace( temp)
  #pd @res_hier.inspect

  # TextMate.exit_discard unless res_hier[:current_type]
  type_chain = temp[:current_type].dup
  rightMostClass(type_chain, namespace, qualifier)

end

end
#{:current_type=>[{:name=>"map", :kind=>:field, :bind=>"."},
#                 {:name=>"begin", :kind=>:method, :bind=>"->"},
#                 {:name=>"second", :kind=>:field, :bind=>"."},
#                 {:prefix=>"met"}]
# "map"=>{:type=>"std::map", 1=>{:type=>"std::vector", 1=>{:type=>"a"}}, 2=>{:type=>"b"}}}