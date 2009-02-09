require ENV['TM_SUPPORT_PATH'] + '/lib/ui'
require ENV['TM_SUPPORT_PATH'] + '/lib/tm/process'

class JavaClassBrowser
  
  @@nib = "#{File.dirname(__FILE__)}/../nibs/JavaClassBrowser.nib"
  
  def initialize(project)
    @project = project
  end
  
  def show
    TextMate::UI.dialog(:nib => @@nib, :center => true, :parameters => initial_parameters) do |dialog|
      p = dialog.wait_for_input do |params|
        if params["returnButton"] == "Close"
          false
        else
          TextMate::Process.run("mate", @project.path + "/" + params["returnArgument"].first)
          false
        end
      end
    end
    
  end
  
  def initial_parameters
    { 
      "classes" => @project.classes.to_a
    }
  end
  
end