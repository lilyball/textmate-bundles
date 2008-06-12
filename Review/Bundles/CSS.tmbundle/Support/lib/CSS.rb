#!/usr/bin/env ruby
# Add prefix to all selected CSS rules
# If you're adding multiple prefixes, then duplicate all rules

module SubtleGradient
  module CSS
    
    class StyleSheet
      def initialize(raw='')
        @raw = raw
      end
      
      def to_s
        rules * "\n" + "\n"
      end
      
      def rules
        @children ||= Rule::parse(@raw)
      end
      alias :children :rules
      
      def add_prefix(prefix)
        # TODO: Be smart about mapping methods to children
        @children = children.map { |c| c.add_prefix(prefix) }
        return self
      end
      
      # TODO: Add formatting methods
    end
    
    class Rule
      attr_reader :raw
      def initialize(raw = '')
        @raw             = raw
        raw              = raw.split(/(?=\{)/)
        @raw_selector    = raw.first
        @raw_rule        = raw.last
      end
      
      def to_s
        [selectors * ', ', @raw_rule] * ''
      end
      
      def selectors
        @children ||= Selector::parse(@raw)
      end
      alias :children :selectors
      
      def add_prefix(prefix)
        # TODO: Be smart about mapping methods to children
        @children = children.map { |c| c.add_prefix(prefix) }
        return self
      end
      
      class << self
        def parse(raw)
          return false if raw.nil? or raw.empty?
          # Return a bunch of new Rule objects in an array, 
          # ordered as they are in the raw input
          
          # Remove comments
          raw.gsub!(%r`/\*.*?\*/`,'')
          
          rules = raw.scan /^.*?$/
          rules.collect! do |rule|
            Rule.new(rule)
          end
          
        end
      end
    end
    
    class Selector
      def initialize(raw='')
        @raw = raw
      end
      
      def to_s
        @raw
      end
      def inspect
        to_s.inspect
      end
      
      def add_prefix(prefix)
        "#{prefix} #{to_s}"
      end
      
      class << self
        def parse(raw)
          # Return a bunch of new Selector objects in an array, 
          # ordered as they are in the raw input
          
          # Remove comments
          raw.gsub!(%r`/\*.*?\*/`,'')
          
          selectors = raw.scan(%r`(?m)(?:\A|\*/|,|\})\n?\s*(.*?)\s*(?=[\{,])`).flatten
          selectors.map { |s| Selector.new(s) }
        end
      end
    end
  end
end

if __FILE__ == $0
  require 'CSS.test.rb'
end
