#!/usr/bin/env ruby
require "test/unit"
require "CSS"

class TestSubtleGradientCSS < Test::Unit::TestCase
  def test_parse_Selector
    css = SubtleGradient::CSS::Selector.parse <<-CSS
div, #bb, .aa {}
    CSS
    
    assert css
    assert_equal 3, css.length
  end

  def test_parse_Rule
    css = SubtleGradient::CSS::Rule.parse <<-CSS
div{color:red}
#bb{color:green}
.aa{color:blue}
    CSS
    
    assert css
    assert_equal 3, css.length
  end
  
  def test_parse_StyleSheet
    raw = <<-CSS
div{color:red}
#bb{color:green}
.aa{color:blue}
    CSS
    css = SubtleGradient::CSS::StyleSheet.new raw
    
    assert css
    assert css.rules
    assert_equal raw, css.to_s
    # assert_equal 3, css.rules.length
  end
  
  def test_add_prefix_Selector
    css = SubtleGradient::CSS::Selector.parse <<-CSS
div, #bb, .aa {}
    CSS
    prefix = '#prefix'
    
    assert css
    assert_equal ["#{prefix} div", "#{prefix} #bb", "#{prefix} .aa"], css.map { |c| c.add_prefix(prefix) }
  end
  
  def test_add_prefix_Rule
    css = SubtleGradient::CSS::Rule.parse <<-CSS
div, #bb, .aa {color:red}
div, #bb, .aa {color:green}
div, #bb, .aa {color:blue}
    CSS
    prefix = '#prefix'
    
    assert css
    assert css.to_s, <<-CSS
#{prefix} div, #{prefix} #bb, #{prefix} .aa {color:red}
#{prefix} div, #{prefix} #bb, #{prefix} .aa {color:green}
#{prefix} div, #{prefix} #bb, #{prefix} .aa {color:blue}
    CSS
  end
  
  def test_add_prefix_StyleSheet
    raw = <<-CSS
.pc6 p a:hover{text-shadow:1px 1px 2px #fff;}
.pc6 p a:active{text-shadow:none;}
/* @group Button */
.pc6 .pc6w1,.pc6 .pc6x1,.pc6 .pc6x2{background:url('/images/jv0dl_a.png') no-repeat bottom left;display:block;overflow:hidden;margin:0 auto;width:224px;}
    CSS
    prefix='#prefix'
    css = SubtleGradient::CSS::StyleSheet.new(raw)
    css0 = css.add_prefix(prefix).to_s
    
    # print css.to_s
    # print css0.to_s
    
    assert css
    assert_equal <<-CSS, css0
#{prefix} .pc6 p a:hover{text-shadow:1px 1px 2px #fff;}
#{prefix} .pc6 p a:active{text-shadow:none;}

#{prefix} .pc6 .pc6w1, #{prefix} .pc6 .pc6x1, #{prefix} .pc6 .pc6x2{background:url('/images/jv0dl_a.png') no-repeat bottom left;display:block;overflow:hidden;margin:0 auto;width:224px;}
    CSS
  end
end
