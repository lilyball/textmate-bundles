#!/usr/bin/env ruby

# Copyright:
#   (c) 2006 InquiryLabs, Inc.
#   Visit us at http://inquirylabs.com/
# Author: Duane Johnson (duane.johnson@gmail.com)
# Description:
#   Retrieves plugin data from agilewebdevelopment.com and allows you to install directly.

require 'rails_bundle_tools'
#require 'fileutils'

root = RailsPath.new.rails_root

puts <<-HTML
<style>
  .success {border: 2px solid #99ff66; background-color: #eeffdd;}
  .failure {border: 2px solid #ff9966; background-color: #ffeedd;}
  .loading {border: 2px solid #9999ff; background-color: #eeeeff;}
</style>
<input type="text" name="search" id="search">
<input type="button" value="Go" onClick="search(document.getElementById('search').value)">
<div id="output"></div>
<script>
  var xmlDoc;

  searchQuery = "curl -s -L -H 'Accept: application/xml' http://agilewebdevelopment.com/plugins/search?search=";

  function search(value) {
    printOutput("Searching for '" + value + "':<br>");
  
    var response = TextMate.system(searchQuery + escape(value), null);
    if (response.errorString)
      printOutput("ERROR:" + escape(response.errorString) + "<br>");
    //printOutput("OUTPUT:" + escape(response.outputString) + "<br>");
  
    xmlDoc = new DOMParser().parseFromString(response.outputString, 'text/xml');
    createPluginsTable();
  }
  function getValue(dom, key, defaultValue) {
    try {
      return dom.getElementsByTagName(key)[0].firstChild.nodeValue;
    } catch(e) {
      return (defaultValue || null);
    }
  }
  
  function createPluginsTable() {
    var pluginNodes = xmlDoc.getElementsByTagName('plugin');
    var output = document.getElementById('output');
    var table, row, cell, link, img;
    
    table = document.createElement('table');
    
    for (var i = 0; i < pluginNodes.length; i++) {
      var name       = getValue(pluginNodes[i], 'name');
      var home       = getValue(pluginNodes[i], 'home');
      var repository = getValue(pluginNodes[i], 'repository');
      var rating     = getValue(pluginNodes[i], 'rating');
      var license    = getValue(pluginNodes[i], 'license');
      var summary    = getValue(pluginNodes[i], 'link');
      
      row = document.createElement("tr");
      
      cell = document.createElement("td");
      cell.appendChild(createLink({text: name, href: summary}));
      row.appendChild(cell);
      
      cell = document.createElement("td");
      cell.appendChild(createLink({image: "home.gif", href: home}));
      row.appendChild(cell);
      
      cell = document.createElement("td");
      cell.appendChild(createLink({image: "svn.png", href: repository}));
      row.appendChild(cell);
      
      cell = document.createElement("td");
      cell.appendChild(link = createLink({image: "install.gif", href: "#",
        onclick: function() {
          var output = document.getElementById('output');
          var command = "cd #{root}; ruby script/plugin install " + this.repository;
          output.innerHTML = "<div class='loading'>" + command + "<br>Installing...</div>";
          
          var response = TextMate.system(command, null);
          var string = "";
          if (response.errorString)
            string += "<div class='failure'><code><pre>" + response.errorString.replace(/</m, "&lt;") + "</pre></code></div>";
          string += "<div class='success'><code><pre>" + response.outputString.replace(/</m, "&lt;") + "</pre></code></div>";
          output.innerHTML = string;
        }}));
      link.repository = repository;
      row.appendChild(cell);
      
      table.appendChild(row);
    }
    output.innerHTML = "";
    output.appendChild(table);
  }
  
  function createLink(options) {
    var link = document.createElement('a');
    link.href = options["href"];
    link.onclick = options["onclick"];
    if (options["text"]) {
      link.appendChild(document.createTextNode(options["text"]));
    } else if (options["image"]) {
      var img = document.createElement("img");
      img.src = "file://#{File.join(TextMate.bundle_path, 'Support', 'images')}/" + options["image"];
      link.appendChild(img);
    }
    return link;
  }
  function printOutput(text) {
    var output = document.getElementById('output');
    output.innerHTML += text;
  }
</script>
HTML

# ---- 2 ----
# require 'rexml/document'
# 
# class Parser
#   attr_reader :plugins
# 
#   def initialize
#     reset
#   end
# 
#   def tag_start(name, attributes)
#     if name == 'plugin'
#       @current = Plugin.new
#     end
#   end
# 
#   # we have one, add him to the entries list
#   def tag_end(name)
#     if name == 'plugin'
#       @plugins << @current
#     else
#       method = "#{name}="
#       @current.send(method, @text) if @current.respond_to?(method)
#     end
#     @text = ''
#   end
# 
#   def text(text)
#       @text += text
#   end
# 
#   def xmldecl(version, encoding, standalone)
#     # ignore
#   end
# 
#   # get ready for another parse
#   def reset
#     @plugins = []
#     @text = ''
#   end
# end
# 
# class Plugin
#   attr_accessor :name, :home, :rating, :license, :link
#   def to_html
#     "<b>#{name}</b>: #{link}"
#   end
# end
# 
# xml = `curl -s -L -H 'Accept: application/xml' http://www.agilewebdevelopment.com/plugins`
# 
# REXML::Document.parse_stream(xml, parser = Parser.new)
# 
# puts "<ul>"
# for p in parser.plugins
#   puts "<li>" + p.to_html + "</li>"
# end
# puts "</ul>"



# ---- 1 ----

# plugins = Dir.glob(File.join(TextMate.bundle_path, 'Support', 'plugins', '*'))
# names = plugins.map { |p| File.basename(p).gsub('_', ' ') }

# $logger.warn plugins.inspect

# if choice = TextMate.choose("Choose a plugin to install:", names)
#   source = plugins[choice]
#   root = RailsPath.new.rails_root
#   
#   if root.nil?
#     TextMate.message "Can't find the Rails application directory structure."
#     TextMate.exit_discard
#   end
#   
#   destination = File.join(root, 'vendor', 'plugins', File.basename(plugins[choice]))
#   if File.exist?(destination)
#     if !TextMate.message_yes_no_cancel("Overwrite the plugin?", :informative_text => "It appears that the plugin is already installed.")
#       TextMate.exit_discard
#     end
#     FileUtils.rm_rf(destination)
#   end
# 
#   FileUtils.cp_r source, destination
#   TextMate.message("Installation successful.  Don't forget to restart your development server.")
# end
