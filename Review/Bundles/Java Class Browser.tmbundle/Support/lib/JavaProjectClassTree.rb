class JavaProjectClassTree
  
  def initialize
    @data = {
      "name" => "",
      "children" => []
    }
  end
  
  def to_a
    @data["children"]
  end
    
  def add_class(package, name, path)
    package_node = get_node(package, true)
    id = (package.nil?) ? name : "#{package}.#{name}"
    attach_node(package_node, id, name, path)
  end
  
  def attach_node(parent, id, name, path)
    node = {
      "name" => name,
      "id" => id,
      "path" => path,
      "children" => []
    }
    parent["children"] << node
    parent["children"].sort! { |a,b| a["name"].casecmp(b["name"]) }
    node
  end
  
  def get_node(path, create = false)
    
    path_components = (path.nil?) ? [] : path.split(".")
    target_node = @data
    path_so_far = nil
    path_components.each do |path_component|
      current_node = target_node
      path_so_far = (path_so_far.nil?) ? path_component : "#{path_so_far}.#{path_component}"
      target_node = current_node["children"].find do |node|
        node["name"] == path_component
      end
      if target_node.nil?
        if create
          target_node = attach_node(current_node, path_so_far, path_component, "")
        else
          return
        end
      end
    end
    target_node
  end
  
end