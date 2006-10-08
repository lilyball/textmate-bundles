require "pp"

class String
  def line_from_index(index)
    lines = self.to_a
    running_length = 0
    lines.each_with_index do |line, i|
      running_length += line.length
      if running_length > index
        return i
      end
    end
  end
end

class FootnoteFilter
  cattr_accessor :no_style
  self.no_style = false
  
  def self.indent(indentation, text)
    initial_indentation = text.scan(/^(\s+)/).flatten.first
    text.to_a.map do |line|
      if line.index(initial_indentation) == 0
        " " * indentation + line[initial_indentation.size..-1]
      end
    end.join
  end
  
  def self.insert_text_before(pattern, indentation, body, new_text)
    index = pattern.is_a?(Regexp) ? body.index(pattern) || body.size : pattern
    body.insert index, indent(indentation, new_text)
  end
  
  def self.filter(controller)
    return if controller.render_without_footnotes
    begin
      abs_root = File.expand_path(RAILS_ROOT)
    
      # Some controller classes come with the Controller:: module and some don't (anyone know why? -- Duane)
      controller_filename = "#{abs_root}/app/controllers/#{controller.class.to_s.underscore}.rb".sub('/controllers/controllers/', '/controllers/')
      controller_text = IO.read(controller_filename)
      index_of_method = (controller_text =~ /def\s+#{controller.action_name}[\s\(]/)
      controller_line_number = controller_text.line_from_index(index_of_method) if index_of_method
    
      performed_render = controller.instance_variable_get("@performed_render")
      template = controller.instance_variable_get("@template")
      if performed_render and template.respond_to?(:first_render) and template.first_render
        template_path = template.first_render.sub(/\.(rhtml|rxhtml|rxml|rjs)$/, "")
        template_extension = $1 || template.pick_template_extension(template_path).to_s
        template_file_name = File.expand_path(template.send(:full_template_path, template_path, template_extension))
        layout_file_name = File.expand_path(template.send(:full_template_path, controller.active_layout, "rhtml"))
        if ["rhtml", "rxhtml"].include? template_extension
          textmate_prefix = "txmt://open?url=file://"
          controller_url = controller_filename
          controller_url += "&line=#{controller_line_number + 1}" if index_of_method
          
          # If the user would like to be responsible for the styles, let them opt out of the styling here
          unless FootnoteFilter.no_style
            insert_text_before %r{</head>}i, 4, controller.response.body, <<-HTML
            <!-- TextMate Footnotes Style -->
            <style>
              #textmate_footnotes_debug {margin-top: 0.5em; text-align: center; color: #999;}
              #textmate_footnotes_debug a {text-decoration: none; color: #bbb;}
              fieldset.textmate_footnotes_debug_info {text-align: left; border: 1px dashed #aaa; padding: 1em; margin: 1em 2em 1em 2em; color: #777;}
            </style>
            <!-- End TextMate Footnotes Style -->
            HTML
          end
          
          if ::MAC_OS_X
            textmate_links = <<-HTML
            <b>TextMate Footnotes</b>:
            <a href="#{textmate_prefix}#{controller_url}">Edit Controller File</a> |
            <a href="#{textmate_prefix}#{template_file_name}">Edit View File</a> |
            <a href="#{textmate_prefix}#{layout_file_name}">Edit Layout File</a><br/>
            HTML
          else
            textmate_links = ""
          end
          textmate_footnotes = <<-HTML
          <!-- TextMate Footnotes -->
          <div style="clear:both"></div>
          <div id="textmate_footnotes_debug">
            #{textmate_links}
            <a href="#" onclick="Element.toggle('session_debug_info');return false">Show Session &#10162;</a> |
            <a href="#" onclick="Element.toggle('cookies_debug_info');return false">Show Cookies &#10162;</a> |
            <a href="#" onclick="Element.toggle('params_debug_info');return false">Show Params &#10162;</a> |
            <a href="#" onclick="Element.toggle('general_debug_info');return false">General Debug &#10162;</a>
            <fieldset id="session_debug_info" class="textmate_footnotes_debug_info" style="display: none">
              <legend>Session</legend>
              #{controller.session.instance_variable_get("@data").inspect}
            </fieldset>
            <fieldset id="cookies_debug_info" class="textmate_footnotes_debug_info" style="display: none">
              <legend>Cookies</legend>
              <code>#{controller.send(:cookies).inspect}</code>
            </fieldset>
            <fieldset id="params_debug_info" class="textmate_footnotes_debug_info" style="display: none">
              <legend>Params</legend>
              <code>#{controller.params.inspect}</code>
            </fieldset>
            <fieldset id="general_debug_info" class="textmate_footnotes_debug_info" style="display: none">
              <legend>General</legend>
            </fieldset>
          </div>
          <!-- End TextMate Footnotes -->
          HTML
          if m = controller.response.body.match(%r{<div[^>]+id=['"]textmate_footnotes['"][^>]*>})
            insert_text_before m.offset(0)[1], 4, controller.response.body, textmate_footnotes
          else
            insert_text_before %r{</body>}i, 4, controller.response.body, textmate_footnotes
          end
        end
      end
    rescue Exception => e
      # Discard footnotes if there are any problems
      RAILS_DEFAULT_LOGGER.error "Textmate Footnotes Exception: #{e}\n#{e.backtrace.join("\n")}"
    end
  end
  
  def self.debug(object)
    begin
      Marshal::dump(object)
      "<pre class='debug_dump'>#{escape(object.to_yaml).gsub("  ", "&nbsp; ")}</pre>"
    rescue Object => e
      # Object couldn't be dumped, perhaps because of singleton methods -- this is the fallback
      "<code class='debug_dump'>#{escape(object.inspect)}</code>"
    end
  end
  
  def self.escape(text)
    text.gsub("<", "&lt;").gsub(">", "&gt;")
  end
end

class ActionController::Base
  attr_accessor :render_without_footnotes
  
  after_filter FootnoteFilter
  
protected
  alias footnotes_original_render render
  def render(options = nil, deprecated_status = nil, &block) #:doc:
    if options.is_a? Hash
      @render_without_footnotes = (options.delete(:footnotes) == false)
    end
    footnotes_original_render(options, deprecated_status, &block)
  end
end