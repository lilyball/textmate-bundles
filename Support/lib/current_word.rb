module Word
  def self.current_word(pat, direction = :both)
    word = ENV['TM_SELECTED_TEXT']
    
    if word.nil? or word.empty?
      line, col = ENV['TM_CURRENT_LINE'], ENV['TM_LINE_INDEX'].to_i
      
      @reg = /(^[#{pat}]*)(.*$\r?\n?)/
      @reg = pat.source if pat.kind_of? Regexp
      
      left, before_match = *line[0...col].reverse.match(@reg)[1..2]
      right, after_match = *line[col..-1]        .match(@reg)[1..2]
      
      before_match.reverse!
      left.reverse!
      
      # p before_match, left, right, after_match
      
      case direction
        when :both then word = [left, right].join('')
        when :left then word = left
        when :right then word = right
        when :hash then word = {
          :line         => [before_match, left, right, after_match].join(''),
          :before_match => before_match,
          :left         => left,
          :right        => right,
          :after_match  => after_match,
        }
      end
    end
    
    word
  end
end

if __FILE__ == $0
  require "test/unit"
  class TestWord < Test::Unit::TestCase
# =begin    
    def test_with_spaces
      ENV['TM_SELECTED_TEXT']= nil
      ENV['TM_CURRENT_LINE'] = <<-EOF
    BeforeAfter    
      EOF
      ENV['TM_LINE_INDEX']   = '10'
      ENV['TM_TAB_SIZE']     = '2'
      assert_equal 'BeforeAfter', Word.current_word('a-zA-Z0-9')
      assert_equal 'Before',      Word.current_word('a-zA-Z0-9',:left)
      assert_equal 'After',       Word.current_word('a-zA-Z0-9',:right)
      
      assert_equal '    Before', Word.current_word(" a-zA-Z",:left)
    end
    
    def test_with_tabs
      ENV['TM_SELECTED_TEXT']= nil
      ENV['TM_CURRENT_LINE'] = <<-EOF
		BeforeAfter		
      EOF
      ENV['TM_LINE_INDEX']   = '8'
      ENV['TM_TAB_SIZE']     = '2'
      assert_equal 'BeforeAfter', Word.current_word('a-zA-Z0-9')
      assert_equal 'Before',      Word.current_word('a-zA-Z0-9',:left)
      assert_equal 'After',       Word.current_word('a-zA-Z0-9',:right)
      
      assert_equal "\t\tBefore", Word.current_word("\ta-zA-Z",:left)
    end
    
    def test_with_dash
      ENV['TM_SELECTED_TEXT']= nil
      ENV['TM_CURRENT_LINE'] = <<-EOF
    Before--After    
      EOF
      ENV['TM_LINE_INDEX']   = '11'
      ENV['TM_TAB_SIZE']     = '2'
      assert_equal 'Before--After', Word.current_word('-a-zA-Z0-9')
      assert_equal 'Before-',      Word.current_word('-a-zA-Z0-9',:left)
      assert_equal '-After',       Word.current_word('-a-zA-Z0-9',:right)
      
      assert_equal 'Before-', Word.current_word("\ta-zA-Z\-",:left)
    end
    
    def test_hash_result
      ENV['TM_SELECTED_TEXT']= nil
      ENV['TM_CURRENT_LINE'] = <<-EOF
  before_match  BeforeAfter  after_match  
      EOF
      ENV['TM_LINE_INDEX']   = '22'
      ENV['TM_TAB_SIZE']     = '2'
      
      word = Word.current_word("a-zA-Z",:hash)
      
      assert_equal ENV['TM_CURRENT_LINE'], "#{word[:line]}"
      assert_equal 'Before', word[:left]
      assert_equal 'After', word[:right]
    end
=begin    
=end
    def test_both_result
      ENV['TM_SELECTED_TEXT']= nil
      ENV['TM_CURRENT_LINE'] = <<-EOF
  before_match  BeforeAfter  after_match  
      EOF
      ENV['TM_LINE_INDEX']   = '22'
      ENV['TM_TAB_SIZE']     = '2'
      
      assert_equal 'BeforeAfter', Word.current_word("a-zA-Z",:both)
    end
    
  end
end
