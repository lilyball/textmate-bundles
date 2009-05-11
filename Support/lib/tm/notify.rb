require ENV['TM_SUPPORT_PATH'] + '/lib/tm/notify/notification'
require ENV['TM_SUPPORT_PATH'] + '/lib/tm/notify/scope_selector_scorer'

module TextMate
  
  class << self
    def notify(scope, title, msg)
      notifications = Notify::Notification.all
      
      max_score = -1
      applicable_notifications = []
      scorer = Notify::ScopeSelectorScorer.new
      
      notifications.each do |notification|  
        score = scorer.score(notification.scope_selector, scope)
        if score == 0
          if notification.scope_selector.empty? and (max_score <= 0)
            applicable_notifications << notification
            max_score = 0
          end
        else  
          if score == max_score
            applicable_notifications << notification
          elsif score > max_score
            applicable_notifications = [notification]
            max_score = score
          end
        end
      end

      applicable_notifications.each do |notification|
        notification.fire(scope, title, msg)
      end
      
    end
  end
end
