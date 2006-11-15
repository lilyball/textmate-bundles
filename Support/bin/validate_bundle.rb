#!/usr/bin/env ruby -w

$: << File.join(File.split(__FILE__).first, '../lib')
require "plist"

$legal_scopes = DATA.read.scan(/.+/)

def visit_value(value, bundle_name = nil)
  case value
  when Array
    value.each { |v| visit_value v, bundle_name }
  when Hash
    value.each_pair do |name, v|
      if name == "name" || name == "contentName"
        unless $legal_scopes.any? { |scope| scope.size <= v.size && scope == v[0...(scope.size)] }
          print "#{bundle_name}: " unless bundle_name.nil?
          puts v
        end
      else
        visit_value v, bundle_name
      end
    end
  end
end

ARGV.each do |bundle|

  old_dir = Dir.getwd
  Dir.chdir(bundle)
  Dir["Syntaxes/*.{tmLanguage,plist}"].each do |grammar|
    open(grammar) do |io|
      plist = PropertyList.load(io)
      bundle_name = ARGV.size == 1 ? nil : File.split(bundle).last
      visit_value plist['patterns'], bundle_name   if plist['patterns']
      visit_value plist['repository'], bundle_name if plist['repository']
    end
  end
  Dir.chdir(old_dir)

end

__END__
comment.block.
comment.line.
constant.character.
constant.language.
constant.numeric.
constant.other.
entity.name.type.
entity.name.function.
entity.name.section.
entity.name.tag.
entity.other.attribute-name.
entity.other.inherited-class.
invalid.deprecated.
invalid.illegal.
keyword.control.
keyword.operator.
keyword.other.
markup.bold.
markup.changed.
markup.deleted.
markup.heading.
markup.inserted.
markup.italic.
markup.list.
markup.other.
markup.quote.
markup.raw.
markup.underline.
meta.
punctuation.definition.
punctuation.section.
punctuation.separator.
punctuation.terminator.
source.
storage.modifier.
storage.type.
string.interpolated.
string.other.
string.quoted.double.
string.quoted.other.
string.quoted.single.
string.quoted.triple.
string.regexp.
string.unquoted.
support.class.
support.constant.
support.function.
support.other.
support.type.
support.variable.
text.
variable.language.
variable.other.
variable.parameter.
