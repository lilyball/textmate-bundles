#!/usr/bin/env ruby
# ENV['TM_GTD_CONTEXT'] = "email home office online writing errand reading someday programming"
# ENV['TM_GTD_DIRECTORY'] = "/Users/haris/Documents/MyGTD"
# ENV['TM_BUNDLE_SUPPORT'] = '/Users/haris/Library/Application Support/TextMate/Bundles/GTDAlt.tmbundle/Support'
require File.join(File.dirname(__FILE__),'GTD.rb')
include GTD
GTD.process_directory
all_actions = GTD.actions
contexts = GTD.get_contexts
contxts = []
for context in contexts
  # puts context
  ar = "{context:\"#{context}\",actions:{"
  actions = all_actions.find_all{ |a| a.context == context}
  acts = []
  for act in actions
    it = "{action:\"#{act.name}\""
    unless act.due.nil? then
      it << ",#{act.due_type || 'due'}date:\"#{act.due}\""
    end
    unless act.note.nil? or act.note == "" then
      it << ",nte:\"#{act.note}\""
    end
    it << ",completed:\"#{act.completed? ? 'yes' : 'no'}\""
    it << ",link:\"#{act.txmt}\",file:\"#{act.file}\",line:\"#{act.line}\""
    it << "}"
    acts << it
  end
  ar << acts.join(",") << "}}"
  contxts << ar
end
puts "{" + contxts.join(",") + "}"