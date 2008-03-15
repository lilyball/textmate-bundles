module TextMate
  module DialogRead
    
    @lib = ENV['TM_DIALOG_READ_DYLIB'] # ENV['TM_SUPPORT_PATH'] + '/lib/tm_dialog_read.dylib'
    raise "'TM_DIALOG_READ_DYLIB' env var is not set" unless @lib

    @switches_and_envars = {
      :nib => 'DIALOG_NIB',
      :title => 'DIALOG_TITLE',
      :prompt => 'DIALOG_PROMPT',
      :string => 'DIALOG_STRING'
    }
    
    @affected_env_vars = ['DYLD_INSERT_LIBRARIES', 'DYLD_FORCE_FLAT_NAMESPACE'] + @switches_and_envars.values
    
    class << self
      def use(settings, &block)

        prev_envs = {}
        
        @affected_env_vars.each { |v| prev_envs[v] = ENV[v] if ENV.has_key? v }
        @switches_and_envars.each { |s,e| ENV[e] = settings[s] if settings.has_key? s }
        
        dil = ENV['DYLD_INSERT_LIBRARIES']
        ENV['DYLD_INSERT_LIBRARIES'] = (dil) ? "#{@lib}:#{dil}" : @lib unless (dil =~ /#{@lib}/)
        ENV['DYLD_FORCE_FLAT_NAMESPACE'] = "1"
        
        block.call
        
        @affected_env_vars.each do |v| 
          if prev_envs.has_key? v
            ENV[v] = prev_envs[v]
          else
            ENV.delete(v)
          end
        end
        
      end
    end
    
  end
end