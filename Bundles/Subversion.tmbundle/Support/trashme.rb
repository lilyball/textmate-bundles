


<%
	button_strip = [	{:status => '?',	:name =>	'Add',		:onclick => 'svnAddFile'},
						{:status => '[^?A]',:name =>	'Revert',	:onclick => 'svnRevertFileConfirm'},
						{:status => 'A',	:name =>	'Revert',	:onclick => 'svnRevertFile'},
						{:status => '?',	:name =>	'Remove',	:onclick => 'svnRemoveFile'},
						{:status => '.*',	:name =>	'Diff',		:onclick => 'sendDiffToTextMate', :or_finder => 1}]		# openWithFinder for image files

%>



<!-- <div class="section"> -->
<table class="status" border="0">

	<%
	match_columns       = '.' * status_column_count
	unknown_file_status = '?' + (' ' * (status_column_count - 1))
	missing_file_status = '!' + (' ' * (status_column_count - 1))
	added_file_status   = 'A' + (' ' * (status_column_count - 1))

	stdin_line_count = 1
	%>

	<% STDIN.each_line do |line| %>
		<tr>
			<%# Check for error first %>
			<% if not /^svn:/.match( line ).nil? then %>
				<td><div class="error"><%= line %></div></td>
			<% else %>
			
				<%# Nope, should have good status %>
				<% match = /^(#{match_columns})(?:\s+)(.*)\n/.match( line ) %>
				<% if match.nil? then %>
				
					<%# Informational text, not status %>
					<td colspan=<%= status_colspan %>><div class="info"><%= line %></div></td>
				<% else %>
					<%
					status          = match[1]
					file            = match[2]
					esc_file        = '&quot;' + CGI.escapeHTML(e_sh_js(file).gsub(/(?=")/, '\\')) + '&quot;'
					esc_displayname = '&quot;' + CGI.escapeHTML(e_sh_js(shorten_path(file)).gsub(/(?=")/, '\\')) + '&quot;'

					# Skip files that we don't want to know about
					next if (status == unknown_file_status and ignore_file_pattern =~ file)
					%>
					<%# Status string %>
					<% status_column_count.times do |i| %>

						<% c = status[i].chr %>
						<% status_class = StatusMap[c] || 'dunno' %> 
						<td class="status_col <%= status_class %>" title="<%= StatusColumnNames[i] + " " + status_class.capitalize %>" id="status<%= stdin_line_count %>">
							<%= c %>
						</td>
					<% end %>
					
					<% button_strip.each do |button| %>
						<% match_status = button[:status] %>
						<% button_name = button[:name] %>
						<td class="<%= button_name.downcase + '_col' %>">
							<% if not status.scan(match_status).empty? %>
								<a href="#" class="<%= button_name.downcase + '_button' %>" onclick="<%= "#{button[:onclick]}(#{esc_file}, #{stdin_line_count})" %>"><%= button_name %></a>
							<% end %>
						</td>
					<% end %>
					
					<%# File path  onclick="<%= onclick
					%>
					<td class="file_col"> <a href="<%= 'txmt://open?url=file://' + (e_url file) %>" class="pathname"><%= shorten_path(file) %></a> </td>
					
				<% end %>							
			<% end %>
		</tr>
		<% stdin_line_count += 1 %>
	<% end %>
</table>

<%= html_footer %>
