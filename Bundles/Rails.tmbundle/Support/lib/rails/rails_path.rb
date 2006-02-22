# Copyright:
#   (c) 2006 syncPEOPLE, LLC.
#   Visit us at http://syncpeople.com/
# Author: Duane Johnson (duane.johnson@gmail.com)
# Description:
#   Makes analyzing of a Rails path + filename easier.

class RailsPath
  attr_reader :filepath
  
  def initialize(filepath = ENV['TM_FILEPATH'])
    @filepath = filepath
  end
  
  # Read in the entire text file
  def read
    @read ||= IO.read(@filepath)
  end

  # Convert the text file in to an array of lines
  def lines
    @lines ||= read.to_a
  end
  
  def basename
    File.basename(@filepath)
  end
  
  def dirname
    File.dirname(@filepath)
  end
  
  def rails_root
    self.class.root_indicators.each do |i|
      if index = @filepath.index(i)
        return @filepath[0...index]
      end
    end

    # Fallback plan if not found through TM_FILEPATH:
    return ENV['TM_PROJECT_DIRECTORY']
    # TODO: Look for the root_indicators inside TM_PROJECT_DIRECTORY and return nil if not found
  end

  def exists?
    File.file?(@filepath)
  end

  def model_name
    basename.scan(/^(.+)\.rb$/).flatten.first
  end

  def model?(check_file_exists = false)
    match = @filepath =~ %r{/models/(.+\.rb)$}
    @tail = $1
    match and (!check_file_exists or exists?)
  end

  def helper_name
    basename.scan(/^(.+)_helper\.rb$/).flatten.first
  end

  def helper?(check_file_exists = false)
    match = @filepath =~ %r{/helpers/(.+_helper\.rb)$}
    @tail = $1
    match and (!check_file_exists or exists?)
  end

  def controller_name
    basename.scan(/^(.+)_controller\.rb$/).flatten.first
  end

  def controller?(check_file_exists = false)
    match = @filepath =~ %r{/controllers/(.+_controller\.rb)$}
    @tail = $1
    match and (!check_file_exists or exists?)
  end
  
  def view_name
    basename.scan(/^(.+)\.(rhtml|rxhtml|rxml|rjs)$/).flatten.first
  end
  
  def view?(check_file_exists = false)
    match = @filepath =~ %r{/views/(.+\.(rhtml|rxml|rxhtml|rjs))$}
    @tail = $1
    match and (!check_file_exists or exists?)
  end

  # View file that does not begin with _
  def view_action?
    view? and basename !~ /^_/
  end

  # View file that begins with _
  def view_partial?
    view? and basename =~ /^_/
  end
  
  def controller_for_view
    modules
    @controller_for_view
  end
  
  def modules(discard_controller = true)
    if view?
      @modules = File.dirname(@tail).split('/')
      @controller_for_view = @modules.pop if discard_controller
    elsif controller? or helper?
      @modules = File.dirname(@tail).split('/')
    end
    @modules
  end
  
  def default_line_number
    TextMate.line_number.to_i
  end
  
  def find(start_line = default_line_number)
    (start_line - 1).upto(lines.size - 1) do |i|
      value = yield(lines[i])
      if value.is_a? Regexp
        value = lines[i].scan(value).flatten.first
      end
      if value
        return value, i + 1
      end
    end
    return nil
  end

  def find_method(start_line = default_line_number)
    find(start_line) { %r{def\s+(\w+)} }
  end
  
  def find_backwards(start_line = default_line_number)
    (start_line - 1).downto(0) do |i|
      value = yield(lines[i])
      if value.is_a? Regexp
        value = lines[i].scan(value).flatten.first
      end
      return value, i+1 if value
    end
    return nil
  end

  def find_method_backwards(start_line = default_line_number)
    find_backwards(start_line) { %r{def\s+(\w+)} }
  end
  
  def self.root_indicators
    %w(/app/controllers/ /app/models/ /app/helpers/ /app/views/ /config/ /db/ /doc/ /lib/ /log/ /public/ /script/ /test/ /vendor/)
  end
end