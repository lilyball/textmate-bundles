
require 'English'

module TextMate

  def TextMate.call_with_progress( args, &block )

    title         = args[:title] || 'Progress'
    message       = args[:message] || 'Frobbing the widget...'

    cocoa_dialog  = "#{ENV['TM_SUPPORT_PATH']}/bin/CocoaDialog.app/Contents/MacOS/CocoaDialog"

    pipe = IO.popen(%Q("#{cocoa_dialog}" progressbar --indeterminate --title "#{title}" --text "#{message}"), "w+")
    begin
      data = block.call
      puts data if data
    ensure
      pipe.close
    end

  end

end
