#!/usr/bin/env ruby
# encoding: utf-8

# TEST
def all_colors
  colors = ''
  # range = 0..15
  range = [0,3,6,9,12,15]
  range.each do|a|
    range.each do|b|
      range.each do|c|
        colors << " #%x" % a
        colors << "%x" % b
        colors << "%x" % c
      end
    end
  end
  colors
end
# doc = all_colors
doc = STDIN.read

VALID_COLOR_BASIC = /#(?:[0-9a-f]{3}|[0-9a-f]{6})\b/i
VALID_COLOR = /^#?(?:[0-9a-f]{3}|[0-9a-f]{6})$/i
class HexColor
  attr :color, true
  def initialize(c)
    self.color = c
  end
  def rgb
    rgb = [0,0,0]
    if color.length > 4
      self.color.match(/#(..)(..)(..)/)
      rgb = [$1.hex, $2.hex, $3.hex]
    else
      self.color.match(/#(.)(.)(.)/)
      rgb = [($1+$1).hex, ($2+$2).hex, ($3+$3).hex]
    end
    return rgb
  end
  
  def r; rgb[0]; end
  def g; rgb[1]; end
  def b; rgb[2]; end
  
  def h; hsl[:h]; end
  def s; hsl[:s]; end
  def l; hsl[:l]; end
  
  def to_s
    %{<div style="background: #{c = self.color.ljust(7)}; color: #{(l < 0.15) ? 'white' : 'black'};"><input type="button" value="c" onclick="replace_color(this.parentNode,'#{self.color}')"/>&nbsp;<tt>#{c}&nbsp;</tt><span class="hsl">#{to_hsl}</span></div>\n}
  end
  def hsl
    hsl = {:h => nil,
           :s => nil,
           :l => nil}
    
    nImax = rgb.max
    nImin = rgb.min
    nSum  = nImin + nImax
    nDif  = (nImax - nImin).to_f
    
    hsl[:l] = nSum.to_f / 2
    hsl[:s] = 0 if r == g and g == b
    
    if    !hsl[:s] and hsl[:l] < 128
      hsl[:s] = 255 * (nDif / nSum)
    elsif !hsl[:s]
      hsl[:s] = 255 * (nDif / (510 - nSum))
    end
    
    if hsl[:s] != 0
      if nImax == r
        hsl[:h] = 60 * (g-b) / nDif
      elsif nImax == g
        hsl[:h] = 60 * (b-r) / nDif+120
      elsif nImax == b
        hsl[:h] = 60 * (r-g) / nDif+240
      end

      if hsl[:h] < 0
        hsl[:h] += 360
      end
    else
      hsl[:h] = -1
    end
    
    # hsl[:h] /= 255 * 3
    hsl[:s] /= 255 * 3
    hsl[:l] /= 255 * 3
    
    hsl
  end
  def to_hsl
    return "L #{(l*100).round}%" if h == -1
    "HSL #{h.round}&deg;,#{(s*100).round}%,#{(l*100).round}%"
  end
  
  def sort_h; h.round.to_s.rjust(4).gsub(' ','0')                  ;end
  def sort_H; (h/25).round.to_s.rjust(4).gsub(' ','0')             ;end
  def sort_s; ((s*10000).round * 1000).to_s.rjust(7).gsub(' ','0') ;end
  def sort_l; ((l*10000).round * 1000).to_s.rjust(7).gsub(' ','0') ;end
  def sort_hsl; return self.l.to_s if s == -1; return sort_h + sort_s + sort_l ;end
  def sort_Hsl; return self.l.to_s if s == -1; return sort_H + sort_l + sort_s ;end
  def sort_hls; return self.l.to_s if s == -1; return sort_h + sort_l + sort_s ;end
  def sort_Hls; return self.l.to_s if s == -1; return sort_H + sort_s + sort_l ;end
  
  class << self
    def show_hex_colors(doc)
      colors, hex_colors = [], []
      doc.scan(VALID_COLOR_BASIC) { |c| colors << c unless colors.include?(c) }
      colors.each { |c| hex_colors.push(HexColor.new(c)) if HexColor.could_be?(c) }
      '<div id="colors">' + hex_colors.sort_by{|c| c.sort_Hsl }.to_s + '</div>'
    end
    
    def could_be?(color=nil)
      r= false
      r= true  if color =~ VALID_COLOR
      r= false if color.length < 3 or color.length > 7 or (color.length > 4 and color.length < 7)
      return r
    end
  end
end

ruby_cmd = ENV['TM_RUBY'] || 'ruby'

print HexColor::show_hex_colors(doc)
puts <<-HTML
<script type="text/javascript" charset="utf-8">
var myCommand = null;
var myElement = null;

function done(){
  document.getElementById("result").innerHTML += '\\n.';
	TextMate.isBusy = false;
}

function end(){
  myCommand.cancel();
	TextMate.isBusy = false;
}

function replace_color(element,color){
	TextMate.isBusy = true;
	
  myElement = element;
  myElement.innerHTML = '[ '+myElement.innerHTML+' ]';
  
  if(myCommand){ end() };
  
  cmd = 'echo "' +color+ '"|"#{ruby_cmd}" "#{ENV['TM_BUNDLE_SUPPORT']}/replace_colors.rb"'
  myCommand              = TextMate.system(cmd, done);
  myCommand.onreadoutput = outputHandler;
  myCommand.onreaderror  = outputHandler;
  
	window.location.hash = "working";
}

function outputHandler(currentStringOnStdout){
  document.getElementById("result").innerHTML = currentStringOnStdout;
  if(currentStringOnStdout != 'No changes made')
    myElement.innerHTML += '√';
}

</script>
<style type="text/css" media="screen">
#colors { border: 2px solid #111; outline: 1px solid #eee; }
span.hsl {float: right; width: 10em; white-space: nowrap; text-align: right;}
#colors div {font-size: 70%; padding: 0.5em;}
input {font-size: 9px;}
</style>
<p id='result'></p>
HTML
