require 'ostruct'

RAILS_ROOT = "."

class MockController
  attr_accessor :template
  
  def initialize(body = "")
    @body = body
  end
  
  def response
    OpenStruct.new(:body => @body)
  end
end
