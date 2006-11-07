#!/usr/bin/env ruby

require 'base64'

path = ARGV[0]
libDir = ARGV[1]
do_encode = (ARGV[2] == 'base64' ? true : false)

package = File.dirname(path)

documentation = File.read(File.join(libDir, path))
documentation.gsub!(/\b(href|src) *= *(['"])([^'"]+)\2/) do |match|
  type = $1
	href = $3
	if href =~ /\w+:\/\//
		match
	elsif href[0] == ?#
	  # unfortunately when using a data: URI or a base tag, anchors don't work right
	  # let's try using javascript instead
	  # yeah, I know it's messy-looking
	  anchor = href[1..-1].gsub("'", "\\'")
	  %{href="javascript:var ary = document.getElementsByTagName('a');\
	    for (var i = 0; i < ary.length; i++) {\
	      if (ary[i].name == '#{anchor}') {\
	        document.body.scrollTop = ary[i].offsetTop;\
	        break;\
	      }\
	    }"}
	else
	  if href =~ %r{(\.\./){2}}
	    href.sub!("../../", "")
	  else
	    href = "#{package}/#{href}"
	  end
	  href.gsub!("\"", "&quot;")
	  href.gsub!("&", "&amp;")
	  case type
    when "src":   %{src="#{libDir.gsub("\"", "&quot;")}/#{href}"}
    when "href":  %{href="javascript:window.top.location.href='javascript:rhelp(\\'#{href.gsub("'", "\\'")}\\')'"}
    else          match
    end
	end
end
# Add a <base> tag
documentation.sub!(/<head\b[^>]*>/, %{\\0\n<base href="file://#{File.join(libDir, path)}" />})
# base64 encode if requested
documentation = Base64.encode64(documentation).gsub("\n","") if do_encode
print documentation
