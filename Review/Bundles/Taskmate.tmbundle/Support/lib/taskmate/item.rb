class Taskmate 
  class Item
    attr_reader :project, :state, :text, :tags, :completed
    
    DATE_FORMAT = '%d.%m.%y %H:%M' # TODO should obviously be a config option
    
    class << self
      def is_item?(line)
        line && (line =~ PATTERNS[:item])
      end
    end
    
    def initialize(str, project = nil)
      str = str.clone
      @tags = []
      str.sub!(/@completed\s*\(([\d\w\-\.:\/ ]*)\)\s*$/, '')
      @completed = $1
      true while str.gsub!(/\s@[\w\d-]+/) { |tag| @tags << tag.strip.intern; '' }
      pattern = PATTERNS[:item_text]
      str.strip.match Regexp.new(pattern)
      @completed.nil? ? set_pending! : set_completed!
      @text = $1.strip
      @project = project
    end
    
    def attributes
      { :state => state, :text => text, :completed => completed, :tags => tags }
    end
    
    def attributes=(attrs)
      attrs.each do |name, value| 
        eval("@#{name} = value")
      end
      @completed_datetime = nil if attrs.include?(:completed)
    end
    
    def tags
      @tags.delete(:@completed)
      @tags << :@completed if completed?
      @tags
    end
    
    def add_tag(tag)
      @tags << tag.to_s.intern      
      @tags.uniq!
    end
    
    def completed?
      @state == Taskmate.completed_symbol
    end
    
    def pending?
      not completed?
    end
    
    def set_completed!
      @state = Taskmate.completed_symbol
      @completed ||= Time.now.strftime(DATE_FORMAT)
    end
    
    def set_pending!
      @state = Taskmate.pending_symbol
      @completed = nil
    end
  
    def toggle_completed!
      completed? ? set_pending! : set_completed!      
      self
    end
    
    def completed_datetime
      @completed_datetime ||= DateTime.parse(completed, DATE_FORMAT)
    end
    
    def to_s
      "#{@state} #{@text} #{tags.join(' ')}".strip +
        (completed? ? " (#{completed})" : '')
    end
    
    def collect_tags(taglist, project)
      if pending?
        tags.each do |tag| 
          taglist.add(tag, project, self)
        end
      else
        taglist.add(:@completed, project, self)
      end
    end
    
    def ==(other)
      text == other.text
    end
  end
end