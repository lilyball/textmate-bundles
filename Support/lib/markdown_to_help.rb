#!/usr/bin/env ruby -wKU

class TreeNode
  attr_accessor :heading, :parent, :level, :count
  def initialize(parent = nil, count = 1)
    @parent = parent
    @level = parent ? parent.level + 1 : 0
    @count = count
    @child = @next = nil
    @heading = nil
  end
  def index
    @parent ? [@parent.index, @count].flatten : []
  end
  def to_s
    child = @child ? "\n<ul style='list-style: none'>\n#{@child}</ul>\n" : ''
    entry = @heading ? "<li>#{index.join '.'} <a href='#sect_#{index.join '.'}'>#{@heading}</a>#{child}</li>\n" : child
    @next ? entry.to_s + @next.to_s : entry.to_s
  end
  def new_child
    abort "Already has child" if @child
    @child = TreeNode.new(self)
  end
  def new_sibling
    @next = TreeNode.new(@parent, @count + 1)
  end
  def new_heading
    "<h#{@level}><a name='sect_#{index.join '.'}'>#{index.join '.'}</a> #{@heading}</h#{@level}>"
  end
end

IO.popen("Markdown.pl|SmartyPants.pl", "r+") do |io|

  Thread.new { ARGF.each_line { |line| io << line }; io.close_write }

  root = tree_node = TreeNode.new
  contents = ''
  io.each_line do |line|
    if line =~ %r{^<h(.)>(.*)</h.>$} then
      level = $1.to_i
      tree_node = tree_node.parent while tree_node.level > level
      tree_node = tree_node.new_child while tree_node.level < level
      tree_node = tree_node.new_sibling if tree_node.heading
      tree_node.heading = $2

      contents << "\n<hr />\n" if level == 1
      line = tree_node.new_heading
    end
    contents << line
  end

  puts "<h2>Table of Contents</h2>"
  puts root
  puts contents
end
