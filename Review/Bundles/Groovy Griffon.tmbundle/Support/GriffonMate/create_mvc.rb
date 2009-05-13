class GriffonCreateMVCCommand < GriffonCommand
  
  def initialize()
    super "create-mvc" do |default|
      TextMate::UI.request_string( 
        :title => "Create MVC Artefacts",
        :prompt => "Enter the name of MVC artefact (e.g. File)",
        :default => ""
      )
    end
    self.colorisations['green'] << /Created (.)+ for (\w)+/
  end

  def construct_command(task, option) 
    if option.nil? or option.empty? 
      return nil
    else
      options = Shellwords.shellwords(option)
      ["#{task} #{options.shift}"] + options
    end
  end
  
end

GriffonCreateMVCCommand.new.run