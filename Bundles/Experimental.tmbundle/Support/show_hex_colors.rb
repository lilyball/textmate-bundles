#!/usr/bin/env ruby

# TEST
def all_colors
  colors = ''
  # range = 0..
  15
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
    %{<div style="background: #{c = self.color.ljust(7)}; color: #{(l < 0.15) ? 'white' : 'black'};">#{c}<span class="hsl">#{to_hsl}</span></div>\n}
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
      hsl[:h] = 0
    end
    
    # hsl[:h] /= 255 * 3
    hsl[:s] /= 255 * 3
    hsl[:l] /= 255 * 3
    
    hsl
  end
  def to_hsl
    "HSL #{h.round}&deg;,#{(s*100).round}%,#{(l*100).round}%"
  end
  
  def sort_h; h.round.to_s.rjust(4).gsub(' ','0')                  ;end
  def sort_s; ((s*10000).round * 1000).to_s.rjust(7).gsub(' ','0') ;end
  def sort_l; ((l*10000).round * 1000).to_s.rjust(7).gsub(' ','0') ;end
  def sort_hsl; return sort_h + sort_s + sort_l ;end
  def sort_hls; return sort_h + sort_l + sort_s ;end
  
  class << self
    def get_color_value()
      
    end
    def show_hex_colors(doc)
      colors, hex_colors = [], []
      doc.scan(/#[0-9a-f]{3,6}/i) { |c| colors.push(c) unless colors.include?(c) }
      colors.each { |c| hex_colors.push(HexColor.new(c)) }
      '<div id="colors">' + hex_colors.sort_by{|c| c.sort_hls }.to_s + '</div>'
    end
  end
end



print HexColor::show_hex_colors(doc)
puts <<-HTML
<style type="text/css" media="screen">
#colors { border: 2px solid #111; outline: 1px solid #eee; }
span.hsl {float: right; width: 10em; white-space: nowrap; text-align: right;}
#colors div {font-size: 0.8em; padding: 0.5em;}
</style>
HTML