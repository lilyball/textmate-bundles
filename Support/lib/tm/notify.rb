require ENV['TM_SUPPORT_PATH'] + '/lib/tm/notification'
require ENV['TM_SUPPORT_PATH'] + '/lib/tm/notification/scope_selector_scorer'

module TextMate
  
  class << self
    def notify(scope, title, msg)
      configs = Notification.all
      
      max_score = -1
      matches = []
      scorer = Notification::ScopeSelectorScorer.new
      
      configs.each do |c|
        score = scorer.score(c.scope_selector, scope)
        if score > 0 or c.scope_selector.empty?
          if score == max_score
            matches << c
          elsif score > max_score
            matches = [c]
            max_score = score
          end
        end
      end

      matches.each do |m|
        m.fire(scope, title, msg)
      end
      
    end
  end
end
