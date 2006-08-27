#!/usr/bin/env ruby

# REGEXP HELPER
# David Lee (c) 2005. 

# License terms: undecided. But i take no responsibility for anything. Pretend
# you're reading the disclaimer part of a Microsoft EULA, that's how little I
# expect to be held accountable for anything.

=begin rdoc

We expect to slurp everything from stdin through a pipe, though you can use it
as a command line tool. First line of input is expected to be a regular
expression. If we're doing matching, leave out the /slashes/, eg:

(.+)z

If we're doing substitution, use slashes to identify the expression as such:

/old/new/ 

Every line after the first is match fodder, used to test the regexp.

To set the sucker up as a TextMate command:

- save this somewhere and chmod +x it so it can run
- change the shebang to point to your local install of ruby 
  (type 'which ruby' to find it)  # NO NEED FOR THAT USING env  --cskiadas
- create a new Command in Textmate (alt-ctrl-cmd-c)
- add the action /path_to_script/rx_helper.rb
- it should operate on the selection and display output text in a tooltip
- bind to the keybinding of your choice (i like alt-ctrl-cmd-x)
- enjoy!

David Lee
=end

class RX_Helper
  def initialize
    @tests     = []
    @successes = []
    @failures  = []
    while input_txt = gets
      if !@rx_type 
        prepare_rx(input_txt) 
      else
        @tests << input_txt 
      end
    end
    puts @rx_match
    process_rx
    
    puts "Successful Matches:\n===================\n" unless !@successes[0]
    @successes.each{|x| puts x};
    
    puts "\nFailed Matches:\n===============\n"       unless !@failures[0]
    @failures.each{|x| puts x}; puts "\n"

  end
  
  def prepare_rx(txt) # set up regexp strings
    if md = txt.match(/\/([^\/]+)\/([^\/]+)\//)
      @rx_type, @rx_match, @rx_subst = 'substitution', md[1], md[2]
    else
      @rx_type, @rx_match            = 'match', txt.chomp!
    end
  end
  
  def process_rx
    case @rx_type
    when 'match'
      while line = @tests.shift()
        begin
        if match = line.match(@rx_match)
          @successes.push line.chop + ' : matched expression'
          n = 0
  				while match[n += 1]
  					@successes.push "\tmatch number [" + n.to_s + '] : ' + match[n]
  				end
  			else
  			  @failures.push line.chop + ' : failed'
  			end
  			rescue RegexpError
  			  puts 'regex invalid. ' + $!
  			  exit
  			end
      end
    when 'substitution'
      puts 'no match' unless @rx_match
      puts 'no subst' unless @rx_subst 
        
      while line = @tests.pop()
        subd = line
        begin
          match = line.sub(@rx_match, @rx_subst)
          if match != line
            @successes.push line.chop + ' : matched expression' +
              "\n\t=> " + match.to_s
          else
            @failures.push  line.chop + ' : failed'
          end
  			rescue RegexpError
  			  puts 'regex invalid. ' + $!
  			  exit
        end
      end
    else
    
    end
  end
  
end

RX_Helper.new
