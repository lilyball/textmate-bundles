class Taskmate
  class Taglist < Hash
    def initialize(taskmate)
      self[:@completed] = []
      taskmate.sources.each { |source| source.collect_tags(self) }
    end
    
    def sorted
      keys.collect{|tag| tag.to_s}.sort
    end
    
    def find_item(item)
      self.collect do |tag, projects|
        projects.collect do |project, items|  
          items.select do |i|
            found = i if i == item
          end
        end
      end.flatten.compact.pop
    end
    
    def add(tag, project, item)
      self[tag] ||= []
      unless t = self[tag].select {|t| t[0] == project }.first
        self[tag] << (t = [project, []])
      end
      t[1] << item
    end
  end  
end