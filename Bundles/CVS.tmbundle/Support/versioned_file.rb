module CVS
  CVS_PATH = ENV['CVS_PATH'] || 'cvs' unless defined?(CVS_PATH)
  
  class VersionedFile
    attr_accessor :path
    
    def initialize(path)
      @path = path
    end
    
    def dirname
      File.dirname @path
    end
    
    def basename
      File.basename @path
    end
    
    def status
      case cvs :status
      when /Status: Up-to-date/i then       :current
      when /Status: Locally Modified/i then :modified
      when /Status: Locally Added/i then    :added
      when /Status: Needs Merge/i then      :stale
      end
    end
    
    def revision
      $1 if cvs(:status) =~ /Working revision:\s*([\d\.]+)/
    end
    
    def revisions(reload = false)
      @revisions = nil if reload
      @revisions ||= cvs(:log).inject([]) { |list,line| list << $1 if line =~ /^revision ([\d\.]+)/i; list}
    end
    
    def diff(revision, other_revision = nil)
      revision, other_revision = expand_revision(revision), expand_revision(other_revision)
      
      if other_revision
        cvs(:diff, "-r #{other_revision} -r #{revision}")
      else
        cvs(:diff, "-r #{revision}")
      end
    end
    
    def version(revision)
      cvs(:update, "-p -r #{expand_revision(revision)}")
    end
    
    def cvs(command, options='')
      %x{cd "#{dirname}"; "#{CVS_PATH}" #{command} #{options} "#{basename}"}
    end

    %w(status revisions diff revision version cvs).each do |method|
      class_eval "def self.#{method}(path, *args); new(path).#{method}(*args); end"
    end
    
    private
    
    def expand_revision(revision)
      case revision
      when :head then 'HEAD'
      when :base then 'BASE'
      when :prev then revisions[revisions.index(self.revision)+1] rescue nil
      else revision
      end
    end
  end
end