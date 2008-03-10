module TextMate
  module DialogRead
    
    @lib = ENV['TM_DIALOG_READ_DYLIB']
    
    class << self
      def init(settings)
        ENV['DIALOG_PROMPT'] = (settings.has_key? :prompt) ? settings[:prompt] : nil
        ENV['DIALOG_TITLE'] = (settings.has_key? :title) ? settings[:title] : nil
        ENV['DIALOG_STRING'] = (settings.has_key? :string) ? settings[:string] : nil
        ENV['DIALOG_NIB'] = (settings.has_key? :nib) ? settings[:nib] : nil
        insert unless inserted?
      end
    
      def inserted? 
          ENV['DYLD_INSERT_LIBRARIES'] =~ /$lib/
      end

      def insert
        if ENV['DYLD_INSERT_LIBRARIES']
            ENV['DYLD_INSERT_LIBRARIES'] = "#{@lib}" + ':' + ENV['DYLD_INSERT_LIBRARIES']
        else
            ENV['DYLD_INSERT_LIBRARIES'] = "#{@lib}"
        end
        ENV['DYLD_FORCE_FLAT_NAMESPACE'] = "1"
      end
    end
  end
end