class Taskmate  
  class Source
    attr_accessor :filename, :projects
  
    def initialize(filename)
      @filename = filename
      @projects = []
      parse File.read(filename)
    end
    
    def completed_items
      projects.collect{|project| project.completed_items}.flatten
    end

    def parse(str)
      project = nil
      str.scan(Regexp.union(PATTERNS[:project], PATTERNS[:item]))  do |match|
        unless match =~ PATTERNS[:item]          
          @projects << project = Project.new(match, self)
        else
          raise NotImplementedError, "You currently can't have todo items without a project.\nAdd at least one project per file above your todo items." if project.nil?
          project << Item.new(match, project)
        end
      end
    end
    
    def collect_tags(tags)
      @projects.each { |project| project.collect_tags(tags) }
    end
    
    def contains_project?(project)
      @projects.each do |p|
        return true if p.name == project.name
      end
      false
    end
    
    def contains_item?(item)
      @projects.each do |project|
        project.items.each { |i| return true if i.text == item.text }
      end
      false
    end
  end
end