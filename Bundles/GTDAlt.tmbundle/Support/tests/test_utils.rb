require "test/unit"
$:.unshift File.join(File.dirname(__FILE__), "..", "bin")
require "GTDUtils.rb"

class TestUtils < Test::Unit::TestCase
  def setup
    @a = [6,2,5,3,4]
    @today = Date.today
  end
  def test_array_next
    assert_equal(6, @a.next(4))
    assert_equal(2, @a.next(6))
    assert_equal(4, @a.next(3))
  end
  def test_array_previous
    assert_equal(6, @a.previous(2))
    assert_equal(4, @a.previous(6))
  end
  def test_date_convert
    assert_equal(DateUtils.convert_date("today"), @today)
    assert_equal(DateUtils.convert_date("1 week"), @today + 7)
    assert_equal(DateUtils.convert_date("1 weeks"), @today + 7)
    assert_equal(DateUtils.convert_date("4 weeks"), @today + 28)
    assert_equal(DateUtils.convert_date("-1 week"), @today - 7)
    assert_equal(DateUtils.convert_date("2 month"), @today >> 2)
    assert_equal(DateUtils.convert_date("In 5 days"), @today + 5)
    nextWednesday = @today + ( 7 + 3 - @today.cwday ) % 7
    assert_equal(DateUtils.convert_date("next wednesday"), nextWednesday)
    assert_equal(DateUtils.convert_date("next wed"), nextWednesday)
    assert_equal(DateUtils.addToDate("2005-06-07",5), Date.parse("2005-06-12"))
    assert_equal(DateUtils.addMonth("2005-06-07"), Date.parse("2005-07-07"))
    assert_equal(DateUtils.subtractMonth("2005-06-07"), Date.parse("2005-05-07"))
  end
end