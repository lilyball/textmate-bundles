# Copyright:
#   (c) 2006 syncPEOPLE, LLC.
#   Visit us at http://syncpeople.com/
# Author: Duane Johnson (duane.johnson@gmail.com)
# Description:
#   Helper module for accesing TextMate facilities such as environment variables.

module TextMate
  class <<self
    # Always return something, or nil, for selected_text
    def doxygen_style
      ds = env(:doxygen_style)
      return ds if !ds.nil?
      "*"
    end

    def current_word
      env(:current_word)
    end

    def selected_text
      env(:selected_text)
    end
    
    # Make line_number 0-base index
    def line_number
      env(:line_number).to_i - 1
    end
    
    # Make column_number 0-base as well
    def column_number
      env(:column_number).to_i - 1
    end

    def project_directory
      env(:project_directory)
    end
    
    def env(var)
      ENV['TM_' + var.to_s.upcase]
    end
    
    # Forward to the TM_* environment variables if method is missing.  Some useful variables include:
    #   selected_text, current_line, column_number, line_number, support_path
    def method_missing(method, *args)
      if value = env(method)
        return value
      else
        super(method, *args)
      end
    end
  end
end
