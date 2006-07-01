This is a general help file for the GTDAlt  bundle, one of the *two* bundles for implementing [GTD](http://en.wikipedia.org/wiki/Gtd) in [TextMate](http://www.macromates.com).

# Why two bundles?

You might have noticed that there is a GTD bundle and a GTDAlt bundle. Why two bundles? Because different people implement GTD differently, and because variety never hurt anyone :). The two bundles were created by two different people, and they have very different workflows. So try them both and choose the one you prefer!

---
You can also access this file from within the TextMate bundle. This file consists of three parts. The first part is an introduction to the bundle, describing how to use it. The second describes its internals, describing how to extend the bundle. The third is an example of creating a new command.

# Using the GTDAlt bundle

First of all, let's describe the GTD format. Here is a typical file:

    project World domination
    #completed:[2006-06-20]  @office Assemble email address of world leaders
      @errand Create giant laser beam
      @email Threaten to destroy Barbados
      @work Take over world
    end
    @email Hello there
    project testing project
      project Some subproject
        @homework first action  due:[2006-07-20]
        @email another action
        @email a third action
      end
      
      @home Hurray [1] due:[2006-07-04]
      @home second action [2] due:[2006-06-04]
      @errand a new one [3]
      @email a third action
    end
    [1] A note here <http://www.google.com>
    [2] Another note
    [3] A third note

As you can see it has a very simple minimalistic style. Projects start with a `project` line, and end with an `end` line, and they can be nested. Actions start with an at-sign, which is then followed by the context. Contexts can contain any non-space character. Then comes the name of the action, which is followed by two optional parts. The first one is a bracketed number, and signifies the presence of a note for the action. Notes are all at the end, and can contain links in brackets. The second optional part is a due date, in the format `due:[yyyy-mm-dd]`.
---
**Updates:** Some things have changed a bit:

1. First, GTDAlt now allows `from:` and `at:` instead of `due:`, but for the time being doesn't yet do anything with them.
2. Entering a new context has changed slightly. First, it is imperative that you set up the variable `TM_GTD_CONTEXT` to hold a space-separated list of all the context you want to be using. Then, when you try to create a new command the context is selected, with a current value. Type the first few characters of the desired context you want to switch to, and press tab, and the context will be automatically completed.
3. When you want a new action with the same context as the previous action, press `shift-enter` instead of plain `enter`.
4. A lot of shortcuts have changed. Look in the bundle for details.

---
Now let's describe the workflow for working with a gtd file:

1. You create a new project via a snippet with shortcut the exclamation point `!` (`shift-1`).
2. You create a new action by typing `shift-2` (`@`). This sets a default context (email) which can then be changed as described in the next steps. At this stage you only enter the name of the action.
3. There are three ways to change the context. You could of course just select it and type in. You can also press `ctrl-C` anywhere in the line, which changes the context to the next context in alphabetical order. Also `ctrl-opt-C` offers a pop-up of all contexts to pick from. These contexts are assembled by scanning all gtd files in the given directory, or by simply looking at the environment variable `TM_GTD_CONTEXT`, space-separated.
4. Pressing `ctrl-{` (`ctrl-shift=[`) adds a note. If a note is present, it takes you to the note for editing. The same keypress takes you back to the action.
5. Pressing `ctrl-?` (`ctrl-shift-/`) shows the note of the action in the current line as a tooltip.
6. Pressing `#` (`shift-3`) adds a due date to the current line's action. A popup shows up, asking you to enter a date. You can either enter a date in a standard format, or you can type something like “today”, “in 2 months“ or “next tuesday”.
7. Once a due date has be set, you can either completely change the date by the exact same keypress, which will allow you to enter a new date, or you can use one of a series of commands for adjusting the date:
  + `shift-,` (`<`) reduces the date by one day.
  + `shift-.` (`>`) increases the date by one day.
  + `ctrl-,` reduces the date by one week.
  + `ctrl-.` increases the date by one week.
  + `ctrl-shift-,` (`ctrl-<`) reduces the date by one month.
  + `ctrl-shift-.` (`ctrl->`) increases the date by one month.
8. You can mark a line as completed by pressing `cmd-/`. This marks it as the second line in the example above. Pressing it again unmarks it. These two also work with a whole selection of lines, even a selection crossing among various projects.
9. `opt-cmd-/` cleans up the current project, moving information to the file `GTD.gtdlog` in the current directory. This takes care of all completed actions, as well as completed tasks.
10. `ctrl-L` opens all links in the current line to the current browser.
11. `ctrl-shift-W` surrounds the current selection in a project.
12. Finally, pressing `%` (`shift-5`) asks you for a context, and then creates an HTML page with a list of all actions for that context, along with their due dates if any, and the projects they belong to. Each action and project is a link to its file location. Design improvement suggestions for this page are strongly encouraged.
13. `ctrl-opt-P` allows you to move to another project, by showing you a pop-up of all projects from all gtd files. Of course you could use the "Go To Symbol" pop-up (`cmd-shift-T`), but this only shows the projects in the current file.

Finally, the commands in the bundle work by default with the current directory. You can ask them to work with another special directory by setting the variable `TM_GTD_DIRECTORY`.

# The internals of the GTDAlt bundle

First of all, notice that you can browse the RDoc documentation for the bundle under `Support/bin/doc/index.html`. Each command should start with the three lines:

    #!/usr/bin/env ruby
    require ENV['TM_BUNDLE_PATH']+"/bin/GTD.rb"
    include GTD

This sets up the ground-work for working with the GTD module. There are a number of classes in the GTD module, let's look at them one at a time:

## GTDFile

This is the basic class. It has a number of useful class methods, as well as instance methods. A new instance method is created with a command like:

    obj = GTDFile.new(filename)

where `filename` is a path to a gtd file. For instance to load the current file you would use:

    obj = GTDFile.new(ENV['TM_FILEPATH'])

This processes the current file and returns an object (instance of the GTDFile class). You can query this object for data on the gtd file. For instance:

+ `obj.projects` returns an array of projects (Project objects).
+ `obj.actions` returns an array of actions (Action objects).
+ `obj.notes` returns an array of notes (Note objects).
+ `obj.completed_actions` returns an array of completed actions (Action objects marked as completed).

You can recover the text corresponding to file by using `obj.dump_object`. This can for instance be used to reproduce the text after the various completed actions have been removed. The call `obj.cleanup_projects` removes completed actions and projects (a project is completed when all its actions and subprojects are completed). It adds logging information to the class `MyLogger`, which you can recover using `MyLogger.dump`. Check the “Clean-up current file” command to see how this is used. Finally, `obj.actions_for_context(context)` returns all actions with a given context. All this does is:

    return self.actions.find_all {|a| a.context == context}

There are a couple of class methods that allow work with an entire directory.

+ `self.process_instructions` processes all files in the current directory (or the one pointed to by `TM_GTD_DIRECTORY` or the one specified as an extra argument). It returns an array of objects, one for each gtd file in the directory.
+ `self.get_contexts` returns an array of all contexts discovered so far.
+ `self.add_contexts(contexts)` adds the contexts passed to it to the context list.
+ `self.actions_for_context(context)` returns all actions with given context from all files.
+ `self.gtd_files_in_directory` returns all files from the same directory as in `process_instructions`.

## The Linkable mix-in

`Linkable` is a mix-in module that all of the various item classes, like Project and Action, have. It expects that class that includes it to respond to the instance methods `file`, `line` and optionally `name`, and it adds three methods:

+ `uri` returns the file uri scheme of the string returned by `file`. It expects the full path to the file.
+ `txmt` returns a txmt uri scheme of the file described by the string `file` and the line number `line`.
+ `link` returns html code for an anchor link with the link described by `txmt` and link name described by `name`.

## The Project, Action etc classes

These are the classes representing the various items in the file. They have some common instance methods, namely the `file`, `line`, `name` methods, which return the expected things.

Project has a couple of extra obvious instance methods, namely: `subitems` returning the array of subitems, `parent` returning the parent project, or nil if there isn't one, and `end_line` returning the line number where the project's “end” was located. Finally, `completed?` returns whether the Project is completed or not.

Action has some more interesting methods, namely:

+ `due` returns the string of the due date.
+ `project` returns the project the action belongs to, or nil if there isn't one.
+ `note` returns the note text, or an empty string if there isn't one.
+ `completed` and `completed?` return whether the action is completed.
+ `context` returns the string of the context of the current string.

There are two more item classes, Comment and EndMarker, doing some obvious things.

## The Printer class

There is one final class of interest, the Printer class. It is used to generate tabular output out of data provide. It works similarly to the amazing Builder class, it's like a very-poor-man's Builder. First create an instance:

    pr = Printer.new

Then you need to add data to it. Here's an example, straight from the “Actions for context” command:

    pr.table do
      pr.title("Actions for context: #{context}")
      pr.headers(["Action name","Project","Due_by"])
      actions.each do |a|
        proj = if a.project != nil then a.project.link else "none" end
        due = case a.due
          when "",nil
            ""
          when DateLate
            "<span style=\"color:red\">#{a.due}</span>"
          else
            a.due
        end
        pr.row([a.link,proj,due])
      end
    return pr.to_html

Note the class `DateLate`. It simply responds to: `DateLate === date`, where date is either a Date object or a date expressed as a string. It returns `true` if the date is earlier than `Date.today`. The last command, `pr.to_html`, is the one producing html output. `Printer` instances also respond to the method `raw`, which allows you to just add raw html code (e.g. style) directly.

# An Example

Let's create a command that generates an html file with all actions, sorted by their due date breaking ties alphabetically, along with links to the corresponding files, and tooltips showing the notes for those actions that have notes. First, we need to process the directory:

    #!/usr/bin/env ruby
    require ENV['TM_BUNDLE_PATH']+"/bin/GTD.rb"
    include GTD
    objects = GTDFile.process_directory

Then we extract all actions:

    acts = objects.map{|o| o.actions}.flatten

Then we sort them:

    acts.sort! do |a,b|
      da, db = *[a.due, b.due].map {|i| i || ""}  # convert nils to empty strings
      if da == db then
        a.name <=> b.name
      else
        da <=> db
      end
    end

Now we create the printer object:

    pr = Printer.new
    pr.table do
      pr.title "List of all Actions"
      pr.headers(["Action", "Context", "Due by"])
      acts.each do |a|
        due = case a.due
          when "",nil
            ""
          when DateLate
            "<span style=\"color:red\">#{a.due}</span>"
          else
            a.due
        end
        note_part = (a.note != "") ? " title=\"#{a.note}\"" : ""
        text = "<a href=\"#{a.txmt}\"#{note_part}>#{a.name}</a>"
        pr.row([text, a.context, due])
      end
    end

Finally, we print the resulting object:

    puts pr.to_html

This it it, we just created a new command! You'll find it in the bundle, under the key-equivalent `ctrl-%` (`ctrl-shift-5`).


That's it for now. Enjoy!

Later