require "test/unit"
$:.unshift "../lib"
ENV['TM_GTD_CONTEXT'] = ""
ENV['TM_GTD_CONTEXTS'] = "hello there"
require "GTDUtils.rb"

class TestUtils < Test::Unit::TestCase
  def setup
    @a = [6,2,5,3,4]
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
  def test_contexts
    puts GTDContexts.get_env_contexts
    assert_equal(2, GTDContexts.get_env_contexts.length)
    assert_equal(2, GTDContexts.contexts.length)
    GTDContexts.contexts=["hi","you", "there"]
    assert_equal(["hi","there", "you"], GTDContexts.contexts)
    GTDContexts.contexts += ["you", "there", "foo"]
    assert_equal(["foo", "hi","there", "you"], GTDContexts.contexts)
    GTDContexts.contexts << "bar"
    assert_equal(5, GTDContexts.contexts.length)
    GTDContexts.contexts = nil
    assert_equal(2, GTDContexts.contexts.length)
    ENV['TM_GTD_CONTEXTS'] = nil
    GTDContexts.contexts = nil
    assert_equal(6, GTDContexts.contexts.length)
  end
end
