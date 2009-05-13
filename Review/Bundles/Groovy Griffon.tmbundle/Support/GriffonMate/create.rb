class GriffonCreateCommand < GriffonCommand
  
  def initialize()
    super "create" do |default|
      TextMate::UI.request_string( 
        :title => "Create Artefact",
        :prompt => "Enter the kind of artefact (e.g. domain-class)",
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
      ["#{task}-#{options.shift}"] + options
    end
  end
  
end

GriffonCreateCommand.new.run