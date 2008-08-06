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
  #require "cpp_parser"
  #require "#{ENV['TM_BUNDLE_SUPPORT']}/cpp_parser"
  Treetop.load "#{ENV['TM_BUNDLE_SUPPORT']}/cpp_parser"
  attr_accessor :res_hier

  def initialize(line)
     
    @line = handleInput(line)
    @scopes = nil
    @parser = CppParser.new
#    @std = {
#      :namespace => { "std" =>{ :classes => {
#    "map" => {:classes => {"iterator" => {:methods=>{"->" =>[{:a => "", :type=>"pair"}]}},},
#       :methods => { "begin" =>[{ :type => "map::iterator", :a => "()"}],}}}}}}
#    
  @res_hier = {}
  @usr_hier = {}
  
    if p = ENV['TM_PROJECT_DIRECTORY']
      name = "#{ENV['TM_PROJECT_DIRECTORY']}/.cpp.TM_Completions"
      if File.exist? name
        File.open(name) do |file|
          @usr_hier = Marshal.load(file.read)
        end
      end
    end

    @std = {
      :namespace => { "std" =>{ :classes => {
    "map" => { :methods => { 
        "begin" =>[{ :type => "map::iterator", :a => "()"}],
        "clear" =>[{ :type => "void", :a => "()"}],
        "count" =>[{ :type => "size_type", :a => "( const key_type& key )"}],
        "empty" =>[{ :type => "bool", :a => "()"}],
        "end" =>[{ :type => "map::iterator", :a => "()"}],
        "equal_range"=>[{:type=>"pair", #<iterator,iterator>",
                         :a=>"( const key_type& key )",
                         :t=>{ 1=>{:type=>"map::iterator", :t=>{1=>1,2=>2}
                                  }, 
                               2=>{:type=>"map::iterator", :t=>{1=>1,2=>2}
                                  }
                              }
                        }],
        "erase" =>[{ :type => "void", :a => "( iterator pos )"},{ :type => "void", :a => "( iterator start, iterator end )"},{ :type => "size_type", :a => "( const key_type& key )"}],
        "find" =>[{ :type => "map::iterator", :a => "( const key_type& key )"}],
        "insert" =>[{ :type => "map::iterator", :a => "( iterator i, const TYPE& pair )"},{ :type => "void", :a => "( input_iterator start, input_iterator end )"},
          { :type => "pair",
            :a => "( const TYPE& pair )",
            :t => {1=>{:type=>"map::iterator", :t=>{1=>1,2=>2}},
                   2=>{:type=>"bool"}  }}],
        "key_comp" =>[{ :type => "key_compare", :a => "()"}],
        "lower_bound" =>[{ :type => "map::iterator", :a => "( const key_type& key )"}],
        "max_size" =>[{ :type => "size_type", :a => "()"}],
        "rbegin" =>[{ :type => "map::iterator", :a => "()"}],
        "rend" =>[{ :type => "map::iterator", :a => "()"}],
        "size" =>[{ :type => "size_type", :a => "()"}],
        "swap" =>[{ :type => "void", :a => "( container& from )"}],
        "upper_bound" =>[{ :type => "map::iterator", :a => "( const key_type& key )"}],
        "value_comp" =>[{ :type => "value_compare", :a => "()"}],
        },
        :classes => {"iterator" => {:methods=>{"->" =>[{:a => "", :type=>"pair"}]}},}
    },
    
    "vector" => {:methods => { 
      "assign" =>[{ :type => "void", :a => "( size_type num, const TYPE& val )"},
                  { :type => "void", :a => "( input_iterator start, input_iterator end )"}],
      "at" =>[{ :type => 1, :a => "( size_type loc )"}],
      "back" =>[{ :type => 1, :a => "()"}],
      "begin" =>[{ :type => "vector::iterator", :a => "()"}],
      "capacity" =>[{ :type => "size_type", :a => "()"}],
      "clear" =>[{ :type => "void", :a => "()"}],
      "empty" =>[{ :type => "bool", :a => "()"}],
      "end" =>[{ :type => "vector::iterator", :a => "()"}],
      "erase" =>[{ :type => "vector::iterator", :a => "( iterator loc )"},
         { :type => "vector::iterator", :a => "( iterator start, iterator end )"}],
      "front" =>[{ :type => 1, :a => "()"}],
      "insert" =>[{ :type => "vector::iterator",
                    :a => "( iterator loc, const TYPE& val )"},
        { :type => "void", :a => "( iterator loc, size_type num, const TYPE& val )"}],
      "insert" =>[{ :type => "void", 
                    :a => "( iterator loc, input_iterator start, input_iterator end )"}],
      "max_size" =>[{ :type => "size_type", :a => "()"}],
      "pop_back" =>[{ :type => "void", :a => "()"}],
      "push_back" =>[{ :type => "void", :a => "( const TYPE& val )"}],
      "rbegin" =>[{ :type => "vector::iterator", :a => "()"}],
      "rend" =>[{ :type => "vector::iterator", :a => "()"},],
      "reserve" =>[{ :type => "void", :a => "( size_type size )"}],
      "resize" =>[{ :type => "void", :a => "( size_type num, const TYPE& val = TYPE() )"}],
      "size" =>[{ :type => "size_type", :a => "()"}],
      "swap" =>[{ :type => "void", :a => "( container& from )"}],
                                    },
      :classes => {"iterator" => {:methods =>{"->" => [{:a =>"",:type=>1}] }},},
                       },
      "pair" =>{:field=>{"first"=>{:a=>"",:type=>1},
                           "second"=>{:a=>"",:type=>2}
                                          },
                 # :methods =>{"hello" => [{:a =>"",:type=>1}] }
                               },
                             },},},
   :classes => {
      "a" => {:methods => {"methodAb"=>[{:a=>"()",:type => "b"}], 
                           "methodAc"=>[{:a=>"()",:type => "c"}]}},
      "b" => {:methods => {"methodBa"=>[{:a=>"()",:type => "a"}], 
                           "methodBc"=>[{:a=>"()",:type => "c"}]}},
      "c" => {:methods => {"methodCa"=>[{:a=>"()",:type => "a"}], 
                           "methodCb"=>[{:a=>"()",:type => "b"}]}},
                         },
    }
  end
  
  def handleInput(line)
    m = line.match(/\A[^{]+\{/)
    # get class and method name
    header = m[0]
    post = m.post_match
    fname = header.match(/^\s*((?:[A-Za-z_][A-Za-z0-9_]*|::)+)\s*\(/)
    @namespace = fname[1].split("::")
    args = fname.post_match.match(/\)\s*\{/).pre_match.split(',').join(';')
    line =  args + post
    return line
  end
  
  
  def complete(item, scope, qualifier)
    symbolDict = lookupList(item, scope, qualifier)
    suggestions = []   
    mat = (/^#{item[:prefix]}./)
    symbolDict.each do |key, value|
      if key =~ mat
        if value.kind_of?(Array)
          value.each do |item|
            suggestions << { 'display' => key + item[:a], 'cand' => key+"\t"+item[:a], 'match'=> key, 'type'=> "functions"}
          end
        else
          suggestions << { 'display' => key, 'cand' => key, 'match'=> key, 'type'=> "functions"}
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
    lookInUsed = nil # it is interesting to know if :typedef was used
    
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
  
  def applyTypedefHelp(old, typedef)
      vtp = old[:pointers] || 0
      old[:pointers] = vtp + typedef[:pointers]
      old[:t] = typedef[:t]
  end      
  
  def applyTypedef(r, typedef)
    old = r
    if typedef == nil
      typedef = r
    else
      old = r.dup
      if old.kind_of?(Array)
        old.each do |elem|
          applyTypedefHelp(elem, typedef)
        end
      else
        applyTypedefHelp(old, typedef)
      end
    end
    return typedef, old
    
  end
  
  def lookupTHelp(hierachy, scope, qualifier, verify_presence_of)
    scopeCopy = scope.dup
    typedef = nil
    default = [:namespace, :classes]
    qualiferDefault = [:namespace, :classes, :typedefs]
    hierachy.reverse_each do |lib|
      (scope.length + 1 ).times do |i|
        # search at top scope if first part of qualifier is empty
        # e.g.  ::scope::something
        if qualifier.first && qualifier.first.empty?
          qualifier.shift
          scope.replace []
          r, k = traverse(qualifier, lib, qualiferDefault)
        else
          r, k = traverse(scope, lib, default)
          r, k = traverse(qualifier, r, qualiferDefault) unless r.nil?
        end
        #k = traverse(verify_presence_of, r)
        if k == :typedefs
          qualifier.replace(r[:type].split("::"))
          typedef, junk = applyTypedef(r, typedef)
          retry
        end

        r = verify_presence_of.inject(r) do |result, elem|
          break if result.nil?
          result[elem]
        end

        junk, r = applyTypedef(r, typedef) if typedef && r
        if r
          scope.concat(  qualifier)
          return r
        end 
        scope.pop
      end
      scope.replace scopeCopy.dup
    end 
    nil
  end
  
  def lookup(scope, qualifier, verify_presence_of)
    returnT = nil
    std_hier = @std
    user_hier = @usr_hier
    hierachy = [std_hier, user_hier]
    if scope.last == "#localScope"
     hierachy << res_hier
    end
    returnT = lookupTHelp(hierachy, scope, qualifier, verify_presence_of)
    return returnT
  end
  
  # dereferences containers iterators
  def dereference(variableT, item, currentScope, qualifier)
    origScope = currentScope.dup
    origQualifier = qualifier.dup
    vtp = variableT[:pointers] || 0
    ip = item[:dref]
    if ip <= vtp
      return nil
    else
      val = lookup(currentScope, qualifier, [:methods, "->"])
      unless val.nil?
        return val[0]
      else
        currentScope.replace origScope
        qualifier.replace origQualifier
        return nil
      end
    end
  end
  
  # modifies scope and qualifier
  def lookupT(item, scope, qualifier)
    original = scope.dup
    kind = item[:kind]
    lookupTable = {:sfield => :sfield,
                   :field => :sfield,
                   :smethod => :smethod,
                   :method => :smethod}
                
    skind = lookupTable[kind]
    # first look up among the static:s
    r = lookup(scope, qualifier, [skind, item[:name]])
    # if we didn't find anything look up among non-static
    # provided we are supposed to look in both
    unless r || ( kind == skind)
      scope.replace original.dup
      r = lookup(scope, qualifier, [item[:kind], item[:name]])
    end
    if r.nil?
      po "could not look up '#{qualifier.join("::")}' in scope '#{original.join("::")}'"
    end
    return r[0] if item[:kind] == :methods
    return r
  end
  
  def lookupList(item, scope, qualifier)
    r = lookup(scope.dup, qualifier.dup, [:methods])
    k = lookup(scope.dup, qualifier.dup, [:field])

    if r.nil? && k.nil?
      po "could not find symbols starting with #{item[:prefix]}"
    elsif r.nil?
      return k
    elsif k.nil?
      return r
    else
      return k.merge(r)
    end
  end

  def returnTypeHandling(returnType, templates, currentScope, qualifier)

    iterator = false
    if returnType[:type_of]
      iterator = returnType[:iterator]
      returnType, t = rightMostClass(returnType[:type_of],
                                              currentScope, qualifier)
      templates.replace t
      qualifier << "iterator" if iterator
      return
    end
      
    value = returnType[:type]
    if value.kind_of? Numeric
      returnType = templates[value].dup
      templates.replace( returnType[:t]) if returnType[:t]
      currentScope.replace returnType[:scope].dup
      returnTypeHandling(returnType, templates, currentScope, qualifier)
    elsif value.kind_of? Hash
      updateTemplate(variableT, returnType)
    else
      qualifier.replace value.split("::")
    end
    
  end

  def rightMostClass(type_chain, currentScope, qualifier)
    originalScope = currentScope.dup
    if type_chain.first[:name] == "this"
      currentScope.pop
      type_chain.shift
    end
    
    if q = type_chain.first[:qualifier]
      qualifier = q.dup
    end
    
    templates = {}
    returnType = nil
    type_chain.each do |item|
      if item[:name]
        returnType = lookupT(item, currentScope, qualifier)
        if returnType[:t]
          templates = returnType[:t].dup
        end
        returnTypeHandling(returnType,templates, currentScope, qualifier)
        
        if rt = dereference(returnType, item, currentScope, qualifier)
          if rt[:t]
            templates = rt[:t].dup
          end
          returnType = returnTypeHandling(rt,templates, currentScope, qualifier)
        end

      elsif item[:prefix]
        if qualifier.nil?
          TextMate.exit_show_tool_tip "No completion found"
        else
          complete(item, currentScope, qualifier)
        end
      end
    end
    return returnType, templates
  end

def print()
  #TextMate.exit_show_tool_tip @line
  a = @parser.parse(@line)
  TextMate.exit_discard if a.nil?
  qualifier = []
  #pop off methodname 
  @namespace.pop
  
  namespace = ["rubinius"]
  namespace += @namespace
  namespace << "#localScope"
  temp = a.types namespace.dup
  k = namespace.inject(@res_hier) do |result, elem|
    a = {}
    result[:classes] = { elem => a}
    a
  end
  k.replace( temp)
  #require 'pp'
  #pp temp
  #pd ""
  po "No completion available" unless temp[:current_type]
  type_chain = temp[:current_type].dup
  rightMostClass(type_chain, namespace, qualifier)

end

end
