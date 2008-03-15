#!/usr/bin/env ruby

ENV['TM_DIALOG_READ_DYLIB'] = File.dirname(__FILE__) + "/../../build/tm_dialog_read.dylib"
require "../../helpers/tm_dialog_read"
require ENV['TM_SUPPORT_PATH'] + "/lib/scriptmate"

TextMate::DialogRead.use :title => "Title", :prompt => "Prompt", :string => "String", :nib => "RequestSecureString" do 
  my_popen3('ruby -e "puts gets"')
end
