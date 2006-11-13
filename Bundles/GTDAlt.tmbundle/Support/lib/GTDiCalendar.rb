require File.join(File.dirname(__FILE__),"GTD.rb")
require 'date'
begin
  require 'rubygems'
  require_gem 'icalendar', ">= 0.96"
rescue LoadError
  require 'icalendar'
end
class CalendarWriter
  include Icalendar
  def initialize
    @cal = Calendar.new
    # @items = []
  end
  def add_action(action)
    case action.due_type
    when "at" 
      ev = Event.new
      ev.timestamp = DateTime.now
      ev.start = Date.parse(action.due)
    else
      ev = Todo.new
      ev.due = Date.parse(action.due) if action.due
    end
    ev.summary = action.name
    @cal.add ev
#    ev.comment = "From project: #{action.parent.name} in file #{action.root.name}.\n#{action.note || ""}."
  end
  def +(itemsArray)
    for item in itemsArray do
      case item
      when Component
        puts "here"
        @cal.add item
      when GTD::Action
        add_action item
      end
    end
    self
  end
  def dump
    @cal.to_ical
  end
end
module GTD
  def GTD.calendar_for_context(context)
    acts = GTD.actions_for_context(context)
    cw = CalendarWriter.new
    cw += acts
    puts cw.dump
  end
end
