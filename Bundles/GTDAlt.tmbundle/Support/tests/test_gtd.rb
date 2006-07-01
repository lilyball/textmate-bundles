require "test/unit"
$:.unshift File.join(File.dirname(__FILE__), "..", "bin")
ENV['TM_GTD_CONTEXT'] = "hello there"
require "GTD.rb"
include GTD
class TestGTD < Test::Unit::TestCase
  def test_action
    ENV['TM_GTD_CONTEXTS'] = "hello there"
    @a = Action.new(:name => "the name", :context => "thecontext", :parent => "project", :file => "2005-03-05")
    assert_not_nil(@a)
    assert_equal("the name", @a.name)
    assert_equal("thecontext", @a.context)
    assert_equal("project", @a.parent)
    @b = Action.new(:name => "another action",:context => "emailing",:file => "file2", :line => 15)
    assert_equal("another action", @b.name)
    assert_equal("emailing", @b.context)
    assert_equal(nil, @b.project)
    assert_equal(["file2",15], [@b.file,@b.line])
    assert_equal(nil,@b.due)
  end
  def test_GTD_parse
    File.open("test_example.gtd") do |f|
      @data = f.read
    end
    instructions = GTD::parse(@data)
    assert_not_nil(instructions)
    assert_equal(11, instructions.length)
    assert_equal([:project,:completed,:action,:action,:project,:action,:end,:action,:end,:action,:note],instructions.map{|i| i[0]}[0..10])
    assert_equal([:project,"World domination",nil,nil], instructions[0])
    assert_equal([:action,"Create giant laser beam [1]","errand","2006-06-04"], instructions[2])
    assert_equal([:end,nil,nil,nil], instructions[6])
    assert_equal([:action,"Hello there","email",nil], instructions[9])
  end
  def test_GTDFile_initialize
    @object = GTDFile.new("test_example.gtd")
    assert_not_nil(@object)
    assert_equal(2, @object.projects.length)
    assert_equal(["World domination","A subproject"], @object.projects.map{|i| i.name})
    assert_equal(5, @object.actions.length)
    assert_equal(["Create giant laser beam","Threaten to destroy Barbados","An action","Take over world","Hello there"], @object.actions.map{|i| i.name})
    assert_equal(["email","email-task","errand","hello","testing","there","work"], GTD.contexts)
    assert_equal(7, GTD.contexts.length)
  end
  def test_projects
    test_GTDFile_initialize
    @p1, @p2 = @object.projects
    assert_equal("World domination", @p1.name)
    assert_equal("A subproject", @p2.name)
    assert_equal(@p1,@p2.parent)
    assert_equal(5, @p1.subitems.length)
    @p1.subitems.each do |s|
      assert_equal(@p1, s.parent)
    end
    assert_equal(1,@p2.subitems.length)
  end
  def test_flatten
    test_GTDFile_initialize
    flat = @object.flatten
    assert_equal(9, flat.length)
    flat.each { |item| assert_equal(@object, item.root) }
  end
  def test_actions
    test_projects
    @a1 = @p1.subitems[1]
    assert_equal("Create giant laser beam", @a1.name)
    assert_equal("2006-06-04", @a1.due)
    assert_equal("A note here <http://www.google.com>", @a1.note)
  end
  def test_update
    test_GTDFile_initialize
    l = @object.update!
    assert_equal(11,l)
    assert_equal([0,1,2,3,4,5,6,8,10], @object.flatten.map {|i| i.line})
    assert_not_nil(@object.file)
    @object.flatten.each do |e|
      assert_equal(@object.file,e.file)
    end
  end
  def test_dump_object
    test_GTDFile_initialize
    File.open("test_example.gtd") do |f|
      assert_equal(f.read.chomp, @object.dump_object)
    end
  end
  def test_GTD_singleton_calls
    contexts = GTD.get_contexts
    GTD.process_directory
    @na = GTD.next_actions
    assert_equal(7, @na.length) # Careful. This relies on the contexts of test_example
    GTD.clear_contexts
    GTD.add_contexts(*contexts)
  end
end