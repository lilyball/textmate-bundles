module Word
  def self.current_word(pat)
    word = ENV['TM_SELECTED_TEXT']
    if word.nil? or word.empty?
      line, col = ENV['TM_CURRENT_LINE'], ENV['TM_LINE_INDEX'].to_i
      pat = pat.source if pat.kind_of? Regexp
      word = line[0...col].match(/[#{pat}]*$/).to_s + line[col..-1].match(/^[#{pat}]*/).to_s
    end
    word
  end
end
