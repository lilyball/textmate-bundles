require 'osx/cocoa'

class FileItem
  attr_accessor :file_name
  def initialize(file_name)
    @file_name = file_name
  end
end

class AppController < OSX::NSObject
  include OSX
  ib_outlets :search_field, :close_button, :file_list

  def initialize
    @files = []
    # @file_list.window.makeKeyAndOrderFront(this)
    # SelectWindow(WindowRef)
    # makeMainWindow:
  end

  def add_pressed(sender)
    puts @file_list.selectedRowIndexes.to_a.map {|i| @files[i].file_name }.join(" ")
    quit_application
  end
  ib_action :add_pressed

  def close_dialog(sender)
    quit_application
  end
  ib_action :close_dialog

  # NSSearchField delegate
  def controlTextDidChange(aNotification)
    update_file_list
  end

  # NSTableView data source
  def numberOfRowsInTableView(tblView)
    @files.size
  end

  def tableView_objectValueForTableColumn_row(tblView, col, row)
    identifier = col.identifier
    file = @files[row]
    file.send(identifier.to_s.intern)
  end

  def tableView_setObjectValue_forTableColumn_row(tblView, obj, col, row)
    identifier = col.identifier
    file = @files[row]
    if obj.isKindOfClass?(NSDecimalNumber) then
      obj = obj.to_f
    else
      obj = obj.to_s
    end
    file.send("#{identifier}=".intern, obj)
    updateChangeCount(NSChangeDone)
  end

  # NSTableView delegate
  def tableViewSelectionDidChange(aNotification)
    # @deleteButton.setEnabled(@employees.size > 0 && @tableView.selectedRow != -1)
  end

private
  def quit_application
    OSX::NSApplication.sharedApplication.terminate(self)
  end

  def update_file_list
    @files = matching_files
    @file_list.reloadData
  end

  def search_string
    @search_field.stringValue.to_ruby
  end

  def matching_files
    files = []

    dir = '.'
    if search_string.length > 0
      dir = search_string.gsub(/^((?:\$\$)PWD)/, tm_directory)
    end

    dir = File.dirname(dir) if !File.directory?(dir)
    dir = tm_directory if dir == '.'

    # puts "dir = '#{dir}'"

    ignore = %w(.svn _darcs .obj .moc)
    find_cmd = "find '#{dir}' -maxdepth 1" # | " + ignore.map { |e| "grep -v #{e}" }.join("|")
    output = `#{find_cmd}`.split("\n")
    output.each do |e|
      # next if File.directory?(e)
      e.gsub!(tm_directory, '$$PWD')
      # puts "e = '#{e}', search_string = '#{search_string}'"
      next if Regexp.new(Regexp.escape(search_string)) !~ e
      files << FileItem.new(e)
    end

    return files
  end

  def tm_directory
    ENV['TM_DIRECTORY']
  end
end
