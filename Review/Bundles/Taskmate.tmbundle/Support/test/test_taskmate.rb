require 'test/unit' unless defined? $ZENTEST and $ZENTEST
require 'lib/taskmate.rb'

class TestTaskmate < Test::Unit::TestCase  
  @@dir = './test/data'
  
  def setup
    @taskmate = Taskmate.new(@@dir)
  end
  
  def teardown
    ['@c1', '@c2'].each { |name| File.unlink("#{@@dir}/#{name}.todo") rescue nil }
  end
 
  def file_content(name)
   File.open("#{@@dir}/#{name}.todo") {|f| f.read }.strip
  end

  def test_sources_filenames
    filenames = @taskmate.sources.collect{|source| source.filename}
    assert_equal ["#{@@dir}/test_1.todo", "#{@@dir}/subdir/test_2.todo"], filenames
  end
  
  def test_project_names
    projects = @taskmate.sources.collect{ |file| file.projects }.flatten.collect{ |p| p.name }    
    assert_equal ['Project 1', 'Project 2'], projects
  end
  
  def test_project_items
    items = @taskmate.sources[0].projects[0].items.collect { |i| i.text }
    assert_equal ['foo bar', 'baz'], items
  end
  
  def test_project_item_tags
    tags = @taskmate.sources[0].projects[0].items[0].tags
    assert_equal [:@c1, :@c2], tags
  end
  
  def test_rebuild_files_exists
    @taskmate.rebuild_files
    filename = "#{@@dir}/@c1.todo"
    assert File.exists?(filename), "file was not created: #{@@dir}/@c1.todo"
  end
  
  def test_item_parsing
    line = "\s + text @c1 @completed (18.11.07 13:11) "
    item = Taskmate::Item.new(line)
    expected = ['+', 'text', [:@c1, :@completed], '18.11.07 13:11']
    result = [item.state, item.text, item.tags, item.completed]
    assert_equal expected, result
  end
  
  def test_find_item_source
    item = Taskmate::Item.new("\t+ buz @c1 ")
    project = @taskmate.find_item_source(item)
    assert project.is_a?(Taskmate::Source)
  end
  
  # def test_write_files_contents
  #  @taskmate.write_files
  #  content = /Project 1:\s*[-|\+] foo bar @c1, @c2[\n]*\n*Project 2:\s*[-|\+] buz @c1/
  #  assert content =~ file_content('@c1')
  # end
  # 
  # def test_find_tag_files
  #  assert_equal ["#{@@dir}/@c1.todo", "#{@@dir}/@c2.todo"], @taskmate.tag_filenames('  - foo bar @c1 @c2 ')
  # end
  # 
  # def test_find_project_file
  #   assert_equal "#{@@dir}/subdir/test_2.todo", @taskmate.source_filename("+ buz @c1")
  # end
  # 
  # # def test_toggle_completed_in_source_file
  # #  @taskmate.write_files
  # #  states = (0..1).collect do 
  # #    @taskmate.toggle_completed(:file => "#{@@dir}/test_1.todo", :line => 2)
  # #    /([-|\+]) foo bar/.match(file_content('test_1'))[1]
  # #  end
  # #  assert_not_equal *states
  # # end
end

