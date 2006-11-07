module Word
  def self.current_word(pat)
    word = ENV['TM_SELECTED_TEXT']
    if word.nil? or word.empty?
      line = ENV['TM_CURRENT_LINE']
      column = ENV['TM_COLUMN_NUMBER'].to_i - 1 # columns are 1-based, ruby is 0-based
      pat = pat.source if pat.kind_of? Regexp
      word = line[0...column].match(/[#{pat}]*$/).to_s + line[column..-1].match(/^[#{pat}]*/).to_s
    end
    word
  end
end
