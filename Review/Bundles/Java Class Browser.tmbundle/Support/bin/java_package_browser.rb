#!/usr/bin/env ruby

if not ENV['TM_PROJECT_DIRECTORY'].nil?
  begin
    require ENV['TM_BUNDLE_SUPPORT'] + '/lib/JavaClassBrowser'
    require ENV['TM_BUNDLE_SUPPORT'] + '/lib/Project'

    p = Project.new(ENV['TM_PROJECT_DIRECTORY'])
    p.scan
    jcb = JavaClassBrowser.new(p)
    jcb.show  
  rescue Exception => e
    require ENV['TM_SUPPORT_PATH'] + '/lib/ui'
    TextMate::UI.alert(:critical, "Error", e.inspect + "\n\n" + e.backtrace.to_s)
  end
else
  require ENV['TM_SUPPORT_PATH'] + '/lib/ui'
  TextMate::UI.alert(:critical, "Not A Project", "The Java Class Browser only works for projects.")
end