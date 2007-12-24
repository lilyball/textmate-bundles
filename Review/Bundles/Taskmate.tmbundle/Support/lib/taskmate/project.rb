class Taskmate  
  class Project
    attr_reader :name, :source, :items
  
    def initialize(name, source = nil)
      @name = name.strip.sub(/:$/, '')
      @source = source
      @items = []
    end
    
    def completed_items
      items.select{ |item| item.completed? }
    end
    
    def <<(item)
      @items << item
    end
    
    def collect_tags(tags)
      @items.each { |item| item.collect_tags(tags, self) }
    end
  end
end