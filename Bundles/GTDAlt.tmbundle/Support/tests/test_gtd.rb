require "test/unit"
$:.unshift File.join(File.dirname(__FILE__), "..", "bin")
require "GTD.rb"
include GTD
class TestGTD < Test::Unit::TestCase
  def test_action
    @a = Action.new("the name","thecontext","project","file",20,"2005-03-05")
    assert_not_nil(@a)
    assert_equal("the name", @a.name)
    assert_equal("thecontext", @a.context)
    assert_equal("project", @a.project)
    assert_equal(["file",20], [@a.file,@a.line])
    assert_equal("2005-03-05", @a.due)
    @b = Action.new("another action","emailing",nil,"file2",15,nil)
    assert_equal("another action", @b.name)
    assert_equal("emailing", @b.context)
    assert_equal(nil, @b.project)
    assert_equal(["file2",15], [@b.file,@b.line])
    assert_equal(nil,@b.due)
  end
  def test_GTDFile_parse
    File.open("example.gtd") do |f|
      @data = f.read
    end
    instructions = GTD::parse(@data)
    assert_not_nil(instructions)
    assert_equal(21, instructions.length)
    assert_equal([:project,:comment,:action,:action,:action,:end],instructions.map{|i| i[0]}[0..5])
    assert_equal([:project,"World domination",nil,nil], instructions[0])
    assert_equal([:action,"Create giant laser beam","errand",nil], instructions[2])
    assert_equal([:end,nil,nil,nil], instructions[5])
    assert_equal([:action,"Hurray [1]","home","2006-07-04"], instructions[13])
  end
  def test_GTDFile_initialize
    @object = GTDFile.new("example.gtd")
    assert_not_nil(@object)
    assert_equal(3, @object.projects.length)
    assert_equal(["World domination","testing project","Some subproject"], @object.projects.map{|i| i.name})
    assert_equal([1,8,9],@object.projects.map{|i| i.line})
    assert_equal(11, @object.actions.length)
    assert_equal(["Create giant laser beam","Threaten to destroy Barbados","Take over world","Hello there","first action"], @object.actions[0..4].map{|i| i.name})
    assert_equal(5, GTDFile.get_contexts.length)
    assert_equal(["email","errand","home","homework","work"], GTDFile.get_contexts)
    assert_equal(["example.gtd"], @object.actions.map{|i| i.file}.uniq)
    assert_equal(1, @object.projects[0].line)
    assert_equal(3, @object.actions[0].line)
  end
end