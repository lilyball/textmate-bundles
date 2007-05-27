#!/usr/bin/env ruby

class XMLInput
  def initialize(xml)
    @xml = xml[/^<(.*?)>(.*?)<\/\1>$/m, 2]
    @root_scope = $1
  end
  attr_reader :xml
  
  def self.parse(text)
    xml = XMLInput.new(text)
    xml.xml ? xml : text
  end

  # Tests a scope against a pattern request
  # A Regexp is tested against the scope, and a string is compared against the start of the scope
  def self.match_scope(pattern, scope)
    if pattern.is_a? Regexp
      if pattern.match(scope)
        return $&
      else
        return false
      end
    end

    return pattern if pattern == '*'

    return pattern if scope[0, pattern.length] == pattern
    
    false
  end

  def iterate(*scope_patterns)
    yield_scope = nil
    @xml.gsub(/(?:(<(.*?)>(.*?)<\/\2>)|([^<]*))/m) do
      next if $&.empty?
      if scope = $2
        content = XMLInput.parse($1)
      else
        content = $4
        scope = @root_scope
      end
      yield [content, yield_scope] if scope_patterns.empty? or scope_patterns.find { |pat| yield_scope = XMLInput.match_scope(pat, scope) }
    end
  end

  # Iterate over STDIN
  def self.iterate(*scope_patterns, &block)
    new(STDIN.read).send(:iterate, *scope_patterns, &block)
  end
  
  # Returns just the text
  def to_s
    return xml unless xml[0] == ?<
    s = ''
    iterate do |xml, scope|
      s << xml.to_s
    end
    s
  end
end

if $0 == __FILE__
  class TestSTDIN < IO
    def read
      DATA.read
    end
  end
  STDIN.reopen(TestSTDIN.new(STDIN.fileno))
  
  # =============
  # = doctohtml =
  # =============
  def xml_to_html(xml)
    code_html = ''
    xml.iterate(/.*/) do |xml, scope|
      classes = scope.split(/\./)
      list = []
      begin 
        list.push(classes.join('_'))
      end while classes.pop
      code_html << "<span class=\"#{ list.reverse.join(' ').lstrip }\">"
      if xml.is_a? String
        code_html << xml
      else
        code_html << xml_to_html(xml)
      end
      code_html << '</span>'
    end
    code_html
  end
  # puts xml_to_html(XMLInput.new(DATA.read))
  # exit

  # ======================
  # = Copy condensed SQL =
  # ======================
  res = ''
  XMLInput.iterate('comment', 'string', '*') do |xml, scope|
  # or XMLInput.new(xml).iterate(/^comment/, /^string/, /.*/) do |xml, scope|
  # or XMLInput.new(xml).iterate(/^.*?(?=\..*)?/) do |scope, xml|
    case scope
      when 'comment': # strip this
      when 'string':  res << xml.to_s
      else            res << xml.to_s.gsub(/\s+/, ' ')
    end
  end
  print res
end

__END__
<source.sql><keyword.other.DML.sql>SELECT</keyword.other.DML.sql>     <constant.numeric.sql>1</constant.numeric.sql> 
      <keyword.other.DML.sql>FROm</keyword.other.DML.sql>   <comment.line.double-dash.sql><punctuation.definition.comment.sql>--</punctuation.definition.comment.sql> foo bar bazcxzcjhfkasjkaskfaks
</comment.line.double-dash.sql>        bar <keyword.other.DML.sql>WHERE</keyword.other.DML.sql> i   <keyword.other.data-integrity.sql>in</keyword.other.data-integrity.sql> (<constant.numeric.sql>1</constant.numeric.sql>  , <constant.numeric.sql>2</constant.numeric.sql> <constant.numeric.sql>3</constant.numeric.sql>)
          <keyword.other.DML.sql>AND</keyword.other.DML.sql> foo <keyword.operator.comparison.sql>=</keyword.operator.comparison.sql> <string.quoted.double.sql><punctuation.definition.string.begin.sql>"</punctuation.definition.string.begin.sql>


          sdas


          <punctuation.definition.string.end.sql>"</punctuation.definition.string.end.sql></string.quoted.double.sql>

</source.sql>