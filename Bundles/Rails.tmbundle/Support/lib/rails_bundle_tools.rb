# Copyright:
#   (c) 2006 syncPEOPLE, LLC.
#   Visit us at http://syncpeople.com/
# Author: Duane Johnson (duane.johnson@gmail.com)
# Description:
#   Collection of Rails / TextMate classes for Ruby.

require 'rails/text_mate'
require 'rails/rails_path'
require 'rails/unobtrusive_logger'

class String
  def line_from_index(index)
    lines = self.to_a
    running_length = 0
    lines.each_with_index do |line, i|
      running_length += line.length
      if running_length > index
        return i
      end
    end
  end
end
