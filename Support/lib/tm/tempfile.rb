module TextMate
  module IO
    class << self
      # Requires a file ext and takes an optional leading name string.
      # 
      # Usage:
      # 
      #     TextMate::IO.tempfile('diff', 'foo') { |file|
      #       file.write(diff)
      #       `mate -w #{e_sh(file.path)}`
      #     }
      #
      # Note: If you want to use mate to open the result you will need
      # to use the -w option.
      def tempfile(ext, name=nil)
        require 'tmpdir'

        begin
          file = File.new(
            '%s/%s_%s.%s' % [Dir::tmpdir, name || 'untitled', rand(1679615).to_s(36), ext],
            File::RDWR|File::CREAT|File::EXCL, 0600
          )
          
          file.sync = true
          res = yield(file)
          
          file.close
          File.unlink(file.path)

          return res
        rescue Errno::EEXIST
          retry
        end
      end
    end
  end
end
