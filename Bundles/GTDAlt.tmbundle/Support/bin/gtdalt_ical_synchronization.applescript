global the_contexts, the_calendars, the_todo_pairs, the_gtd_data
set_the_contexts()
set_the_calendars()
-- display_calendar_names()
set_the_gtd_data()
-- return
-- display_gtd_data()
get_the_todo_pairs()
process_existing_todos()
-- return result
set_the_gtd_data() -- Need to reread things to not have completed items show up again.
get_the_todo_pairs() -- Need to reread things to not have completed items show up again.
update_gtd_entries()
-- return result
return Logger
property Logger : {}
-- HANDLERS
on update_gtd_entries()
	repeat with a_context in the_gtd_data
		repeat with an_action in actions of a_context
			if completed of an_action as boolean is false then
				set candidate to find_gtd_in_todos(contents of an_action)
				if candidate is "not found" then
					create_new_entry from an_action into (context of a_context)
				else
					update_new_entry for candidate from an_action
				end if
			end if
		end repeat
	end repeat
end update_gtd_entries
on create_new_entry from the_action_rec into the_context
	set end of Logger to "Creating new entry:" & action of the_action_rec & " in context:" & the_context
	tell application "iCal"
		set the_cal to get first calendar where name is ("GTDALT" & the_context)
		set the_todo to make todo at the end of the_cal
		set summary of the_todo to action of the_action_rec
		set temp_date to "not found"
		try
			set temp_date to (duedate of the_action_rec)
		end try
		if temp_date is not "not found" then
			set due date of the_todo to (my get_date(temp_date))
		end if
		try
			set description of the_todo to (nte of the_action_rec)
		end try
		set stamp date of the_todo to current date
		set url of the_todo to (link of the_action_rec)
	end tell
end create_new_entry
on update_new_entry for todo_rec from the_action_rec
	-- set end of Logger to "Updating entry:" & (f_todo of todo_rec) & "with entry:" -- & (action of the_action_rec)
	tell application "iCal"
		set the_todo to f_todo of todo_rec
		set temp_date to "not found"
		try
			set temp_date to (duedate of the_action_rec)
		end try
		if temp_date is not "not found" then
			set due date of the_todo to (my get_date(temp_date))
		end if
		try
			set description of the_todo to (nte of the_action_rec)
		end try
		set stamp date of the_todo to current date
		set url of the_todo to (link of the_action_rec)
	end tell
end update_new_entry
on find_gtd_in_todos(gtd_action)
	global the_contexts, the_calendars, the_todo_pairs, the_gtd_data
	local the_name
	set the_name to action of gtd_action
	tell application "iCal"
		repeat with todo_rec in the_todo_pairs
			if (summary of f_todo of todo_rec) = the_name then
				return todo_rec
			end if
		end repeat
		return "not found"
	end tell
end find_gtd_in_todos
on find_todo_in_gtd(todo_item)
	global the_contexts, the_calendars, the_todo_pairs, the_gtd_data
	local the_name
	tell application "iCal"
		set the_name to summary of todo_item
		repeat with context in the_gtd_data
			repeat with candidate in actions of context
				if contents of action of candidate is equal to the_name then
					return candidate
				end if
			end repeat
		end repeat
		return "not found"
	end tell
end find_todo_in_gtd
on process_existing_todos()
	global the_contexts, the_calendars, the_todo_pairs, the_gtd_data
	local todo_pair, suspect
	set suspect_list to {}
	set the_command to do shell script "echo -n $TM_BUNDLE_SUPPORT"
	repeat with todo_pair in the_todo_pairs
		set suspect to find_todo_in_gtd(contents of f_todo of todo_pair)
		if suspect is not "not found" then
			tell application "iCal"
				set the_date to completion date of f_todo of todo_pair
				set temp_test to false
				try
					the_date -- The try block will fail right here if there was no completion date
					set temp_test to true
				end try
				if temp_test is true then
					set todo_to_delete to f_todo of todo_pair
					-- display dialog "Will delete" & summary of todo_to_delete
					set end of suspect_list to do shell script "\"" & the_command & "/bin/mark_completed.rb\" \"" & (action of suspect) & "\" \"" & (file of suspect) & "\" " & (line of suspect)
					-- return todo_to_delete
					delete todo_to_delete
					-- set end of suspect_list to todo_to_delete
					-- end try
				end if
			end tell
		else  -- No suspect found, this means the todo is redundant.
			tell application "iCal"
				-- display dialog "About to delete something!"
				delete f_todo of todo_pair
			end tell
		end if
	end repeat
	return suspect_list
end process_existing_todos
on set_the_gtd_data()
	global the_gtd_data
	set the_gtd_data to run script (do shell script "\"$TM_BUNDLE_SUPPORT/bin/get_lists.rb\"" without altering line endings)
	-- set test_string to (do shell script "\"/Users/haris/Library/Application Support/TextMate/Bundles/GTDAlt.tmbundle/Support/bin/get_lists.rb\"" without altering line endings)
	-- tell application "iCal"
	-- 	display dialog test_string
	-- end tell
	set the_gtd_data to run script test_string
end set_the_gtd_data
on set_the_calendars() -- Reads calendars from iCal
	global the_contexts
	global the_calendars
	local temp_var, temp_name
	set the_calendars to {}
	tell application "iCal"
		repeat with C in the_contexts
			set temp_var to {}
			set temp_name to "GTDALT" & C
			set temp_var to get (calendars whose name is temp_name)
			if temp_var is {} then
				-- Need to create a new calendar
				set temp_var to make new calendar
				set name of temp_var to temp_name
				set temp_var to {temp_var}
			end if
			set end of the_calendars to item 1 of temp_var
		end repeat
	end tell
end set_the_calendars

on get_the_todo_pairs() -- Returns a list of records of a calendar and a todo contained in it.
	global the_todo_pairs, the_calendars
	local tod, cal
	set the_todo_pairs to {}
	tell application "iCal"
		repeat with cal in the_calendars
			set the_cal to contents of cal
			repeat with tod in todos of the_cal
				set the_tod to contents of tod
				set end of the_todo_pairs to {f_calendar:cal, f_todo:the_tod}
			end repeat
		end repeat
	end tell
end get_the_todo_pairs

on set_the_contexts() -- Returns a list of the contexts from the variable $TM_GTD_CONTEXT
	--	local cal_names
	global the_contexts
	set the text item delimiters to " "
	set the_contexts to (get text items of (do shell script "echo -n $TM_GTD_CONTEXT" without altering line endings))
end set_the_contexts

on get_date(a_date)
	local d, elements
	set the text item delimiters to "-"
	set elements to text items of a_date
	set d to date (item 3 of elements)
	set month of d to (item 2 of elements)
	set year of d to (item 1 of elements)
	return d
end get_date

-- DEBUGGING HANDLERS
on display_calendar_names()
	global the_calendars
	tell application "iCal"
		set the_list to ""
		repeat with the_cal in the_calendars
			set the_list to the_list & name of the_cal & " "
		end repeat
		display dialog the_list
	end tell
end
on display_gtd_data()
	global the_gtd_data
	set the_string to ""
	-- repeat with the_rec in the_gtd_data
	-- 	set the_string to the_string & "\nContext:" & context of the_rec
	-- 	repeat with the_act in (actions of the_rec)
	-- 		set the_string to the_string & "\n" & action of the_act
	-- 	end repeat
	-- end repeat
	tell app "iCal"
		display dialog the_string
	end tell
end display_gtd_data