module Word
  def self.current_word(pat, direction = :both)
    word = ENV['TM_SELECTED_TEXT']
    if word.nil? or word.empty?
      line, col = ENV['TM_CURRENT_LINE'], ENV['TM_LINE_INDEX'].to_i
      pat = pat.source if pat.kind_of? Regexp

      left  = line[0...col].match(/[#{pat}]*$/).to_s 
	    right = line[col..-1].match(/^[#{pat}]*/).to_s

	    case direction
        when :both then word = left + right
        when :left then word = left
        when :right then word = right
      end
    end
    word
  end
end
