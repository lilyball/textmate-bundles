module TextMate
  module DialogRead
    
    @lib = ENV['TM_DIALOG_READ_DYLIB'] # ENV['TM_SUPPORT_PATH'] + '/lib/tm_dialog_read.dylib'
    raise "'TM_DIALOG_READ_DYLIB' env var is not set" unless @lib
    
    @affected_env_vars = ['DYLD_INSERT_LIBRARIES', 'DYLD_FORCE_FLAT_NAMESPACE', 'DIALOG_TITLE']
    
    class << self
      def use(title, &block)

        prev_envs = {}
        
        @affected_env_vars.each { |v| prev_envs[v] = ENV[v] if ENV.has_key? v }
        
        dil = ENV['DYLD_INSERT_LIBRARIES']
        ENV['DYLD_INSERT_LIBRARIES'] = (dil) ? "#{@lib}:#{dil}" : @lib unless (dil =~ /#{@lib}/)
        ENV['DYLD_FORCE_FLAT_NAMESPACE'] = "1"
        ENV['DIALOG_TITLE'] = title if title
        
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