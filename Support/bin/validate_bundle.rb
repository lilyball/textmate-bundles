#!/usr/bin/env ruby -w

$: << File.join(File.split(__FILE__).first, '../lib')
require "plist"

$legal_scopes = DATA.read.scan(/.+/)

def visit_value(value)
  case value
  when Array
    value.each { |v| visit_value v }
  when Hash
    value.each_pair do |name, v|
      if name == "name" || name == "contentName"
        unless $legal_scopes.any? { |scope| scope.size <= v.size && scope == v[0...(scope.size)] }
          puts v
        end
      else
        visit_value v
      end
    end
  end
end

ARGV.each do |bundle|

  old_dir = Dir.getwd
  Dir.chdir(File.join(old_dir, bundle))
  Dir["Syntaxes/*.{tmLanguage,plist}"].each do |grammar|
    open(grammar) do |io|
      plist = PropertyList.load(io)
      visit_value plist['patterns']   if plist['patterns']
      visit_value plist['repository'] if plist['repository']
    end
  end
  Dir.chdir(old_dir)

end

__END__
comment.block
comment.block.documentation
comment.line
comment.line.double-dash
comment.line.double-slash
comment.line.number-sign
comment.line.percentage
constant.character
constant.character.escape
constant.language
constant.numeric
constant.other
entity.name.class
entity.name.function
entity.name.section
entity.name.tag
entity.other.attribute-name
entity.other.inherited-class
invalid.deprecated
invalid.illegal
keyword.control
keyword.operator
keyword.other
markup.bold
markup.heading
markup.italic
markup.list
markup.list.numbered
markup.list.unnumbered
markup.other
markup.quote
markup.raw
markup.underline
markup.underline.link
meta
source
storage.modifier
storage.type
string.interpolated
string.other
string.quoted.double
string.quoted.other
string.quoted.single
string.quoted.triple
string.regexp
string.unquoted
support.class
support.constant
support.function
support.other
support.type
support.variable
text
variable.language
variable.other
variable.parameter
