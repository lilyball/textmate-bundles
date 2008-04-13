module Cpp
  include Treetop::Runtime

  def root
    @root || :cpp
  end

  module Cpp0
	def types
		r = {}
		elements.each do |e|
			key, value = e.types
			r[key] = value if key && value
		end
		return r
	end
  end

  def _nt_cpp
    start_index = index
    if node_cache[:cpp].has_key?(index)
      cached = node_cache[:cpp][index]
      @index = cached.interval.end if cached
      return cached
    end

    s0, i0 = [], index
    loop do
      r1 = _nt_statement
      if r1
        s0 << r1
      else
        break
      end
    end
    if s0.empty?
      self.index = i0
      r0 = nil
    else
      r0 = SyntaxNode.new(input, i0...index, s0)
      r0.extend(Cpp0)
    end

    node_cache[:cpp][start_index] = r0

    return r0
  end

  module Statement0
    def explicit_space
      elements[1]
    end

    def complete_declare
      elements[2]
    end
  end

  module Statement1
	def types
	    key = "eu"
	    return key, {:type => "do"}
	end
  end

  module Statement2
	def types
	end
  end

  module Statement3
	def types
	end
  end

  module Statement4
	def types
	end
  end

  def _nt_statement
    start_index = index
    if node_cache[:statement].has_key?(index)
      cached = node_cache[:statement][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    if input.index('typedef', index) == index
      r2 = (SyntaxNode).new(input, index...(index + 7))
      @index += 7
    else
      terminal_parse_failure('typedef')
      r2 = nil
    end
    s1 << r2
    if r2
      r3 = _nt_explicit_space
      s1 << r3
      if r3
        r4 = _nt_complete_declare
        s1 << r4
      end
    end
    if s1.last
      r1 = (SyntaxNode).new(input, i1...index, s1)
      r1.extend(Statement0)
      r1.extend(Statement1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r5 = _nt_complete_declare
      if r5
        r0 = r5
      else
        r6 = _nt_current_type
        if r6
          r0 = r6
        else
          r7 = _nt_allan_macro
          if r7
            r0 = r7
          else
            r8 = _nt_dec
            r8.extend(Statement2)
            if r8
              r0 = r8
            else
              r9 = _nt_string
              r9.extend(Statement3)
              if r9
                r0 = r9
              else
                r10 = _nt_other
                r10.extend(Statement4)
                if r10
                  r0 = r10
                else
                  self.index = i0
                  r0 = nil
                end
              end
            end
          end
        end
      end
    end

    node_cache[:statement][start_index] = r0

    return r0
  end

  module CompleteDeclare0
    def explicit_space
      elements[1]
    end
  end

  module CompleteDeclare1
    def dec
      elements[1]
    end

    def space
      elements[2]
    end

    def variable
      elements[3]
    end
  end

  module CompleteDeclare2
	def types
		return variable.text_value , dec.types#(:type)
	end
  end

  def _nt_complete_declare
    start_index = index
    if node_cache[:complete_declare].has_key?(index)
      cached = node_cache[:complete_declare][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    i2, s2 = index, []
    if input.index('typename', index) == index
      r3 = (SyntaxNode).new(input, index...(index + 8))
      @index += 8
    else
      terminal_parse_failure('typename')
      r3 = nil
    end
    s2 << r3
    if r3
      r4 = _nt_explicit_space
      s2 << r4
    end
    if s2.last
      r2 = (SyntaxNode).new(input, i2...index, s2)
      r2.extend(CompleteDeclare0)
    else
      self.index = i2
      r2 = nil
    end
    if r2
      r1 = r2
    else
      r1 = SyntaxNode.new(input, index...index)
    end
    s0 << r1
    if r1
      r5 = _nt_dec
      s0 << r5
      if r5
        r6 = _nt_space
        s0 << r6
        if r6
          r7 = _nt_variable
          s0 << r7
        end
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(CompleteDeclare1)
      r0.extend(CompleteDeclare2)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:complete_declare][start_index] = r0

    return r0
  end

  module CurrentType0
    def method_chain
      elements[0]
    end

    def prefix
      elements[1]
    end
  end

  module CurrentType1
		def types
			r = method_chain.types
			r << {:prefix => prefix.text_value}
			return :current_type, r
		end
  end

  def _nt_current_type
    start_index = index
    if node_cache[:current_type].has_key?(index)
      cached = node_cache[:current_type][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_method_chain
    s0 << r1
    if r1
      r2 = _nt_prefix
      s0 << r2
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(CurrentType0)
      r0.extend(CurrentType1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:current_type][start_index] = r0

    return r0
  end

  module MethodChain0
    def v
      elements[0]
    end

    def p
      elements[1]
    end

    def t
      elements[2]
    end
  end

  module MethodChain1
		def types
		  r = elements.map do|e|
    if e.p.empty?
		    val = :field
		  else
			val = :method # + :access
		  end
		    { :kind => val, :name => e.v.text_value, :bind => e.t.text_value } 
		  end
		  return r
		end
  end

  def _nt_method_chain
    start_index = index
    if node_cache[:method_chain].has_key?(index)
      cached = node_cache[:method_chain][index]
      @index = cached.interval.end if cached
      return cached
    end

    s0, i0 = [], index
    loop do
      i1, s1 = index, []
      r2 = _nt_variable
      s1 << r2
      if r2
        r4 = _nt_parens
        if r4
          r3 = r4
        else
          r3 = SyntaxNode.new(input, index...index)
        end
        s1 << r3
        if r3
          r5 = _nt_tie
          s1 << r5
        end
      end
      if s1.last
        r1 = (SyntaxNode).new(input, i1...index, s1)
        r1.extend(MethodChain0)
      else
        self.index = i1
        r1 = nil
      end
      if r1
        s0 << r1
      else
        break
      end
    end
    if s0.empty?
      self.index = i0
      r0 = nil
    else
      r0 = SyntaxNode.new(input, i0...index, s0)
      r0.extend(MethodChain1)
    end

    node_cache[:method_chain][start_index] = r0

    return r0
  end

  module AllanMacro0
    def space
      elements[1]
    end

    def it
      elements[2]
    end

    def space
      elements[3]
    end

    def space
      elements[5]
    end

    def dref
      elements[6]
    end

    def space
      elements[7]
    end

    def mc
      elements[8]
    end

    def variable
      elements[9]
    end

    def p
      elements[10]
    end

    def space
      elements[11]
    end

  end

  module AllanMacro1
		def types
		    t = []
		    t << mc.types unless mc.empty?
		    if p.empty?
    	      val = :field
    		else
    		  val = :method # + :access
    		end
    		t << { :kind => val, :name => variable.text_value, :bind => "." } 
		    
		    r = { :type_of => t.flatten, :iterator =>true, :dref => !dref.empty? }
    		return it.text_value, r
		end
  end

  def _nt_allan_macro
    start_index = index
    if node_cache[:allan_macro].has_key?(index)
      cached = node_cache[:allan_macro][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index("iterate(", index) == index
      r1 = (SyntaxNode).new(input, index...(index + 8))
      @index += 8
    else
      terminal_parse_failure("iterate(")
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_space
      s0 << r2
      if r2
        r3 = _nt_variable
        s0 << r3
        if r3
          r4 = _nt_space
          s0 << r4
          if r4
            if input.index(',', index) == index
              r5 = (SyntaxNode).new(input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure(',')
              r5 = nil
            end
            s0 << r5
            if r5
              r6 = _nt_space
              s0 << r6
              if r6
                s7, i7 = [], index
                loop do
                  if input.index('*', index) == index
                    r8 = (SyntaxNode).new(input, index...(index + 1))
                    @index += 1
                  else
                    terminal_parse_failure('*')
                    r8 = nil
                  end
                  if r8
                    s7 << r8
                  else
                    break
                  end
                end
                r7 = SyntaxNode.new(input, i7...index, s7)
                s0 << r7
                if r7
                  r9 = _nt_space
                  s0 << r9
                  if r9
                    r11 = _nt_method_chain
                    if r11
                      r10 = r11
                    else
                      r10 = SyntaxNode.new(input, index...index)
                    end
                    s0 << r10
                    if r10
                      r12 = _nt_variable
                      s0 << r12
                      if r12
                        r14 = _nt_parens
                        if r14
                          r13 = r14
                        else
                          r13 = SyntaxNode.new(input, index...index)
                        end
                        s0 << r13
                        if r13
                          r15 = _nt_space
                          s0 << r15
                          if r15
                            if input.index(')', index) == index
                              r16 = (SyntaxNode).new(input, index...(index + 1))
                              @index += 1
                            else
                              terminal_parse_failure(')')
                              r16 = nil
                            end
                            s0 << r16
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(AllanMacro0)
      r0.extend(AllanMacro1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:allan_macro][start_index] = r0

    return r0
  end

  module Parens0
  end

  module Parens1
  end

  def _nt_parens
    start_index = index
    if node_cache[:parens].has_key?(index)
      cached = node_cache[:parens][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    if input.index('(', index) == index
      r2 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure('(')
      r2 = nil
    end
    s1 << r2
    if r2
      if input.index(')', index) == index
        r3 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure(')')
        r3 = nil
      end
      s1 << r3
    end
    if s1.last
      r1 = (SyntaxNode).new(input, i1...index, s1)
      r1.extend(Parens0)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i4, s4 = index, []
      if input.index('(', index) == index
        r5 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure('(')
        r5 = nil
      end
      s4 << r5
      if r5
        s6, i6 = [], index
        loop do
          r7 = _nt_inner
          if r7
            s6 << r7
          else
            break
          end
        end
        if s6.empty?
          self.index = i6
          r6 = nil
        else
          r6 = SyntaxNode.new(input, i6...index, s6)
        end
        s4 << r6
        if r6
          if input.index(')', index) == index
            r8 = (SyntaxNode).new(input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure(')')
            r8 = nil
          end
          s4 << r8
        end
      end
      if s4.last
        r4 = (SyntaxNode).new(input, i4...index, s4)
        r4.extend(Parens1)
      else
        self.index = i4
        r4 = nil
      end
      if r4
        r0 = r4
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:parens][start_index] = r0

    return r0
  end

  module Inner0
  end

  def _nt_inner
    start_index = index
    if node_cache[:inner].has_key?(index)
      cached = node_cache[:inner][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    i2 = index
    i3 = index
    if input.index('(', index) == index
      r4 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure('(')
      r4 = nil
    end
    if r4
      r3 = r4
    else
      if input.index(')', index) == index
        r5 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure(')')
        r5 = nil
      end
      if r5
        r3 = r5
      else
        self.index = i3
        r3 = nil
      end
    end
    if r3
      r2 = nil
    else
      self.index = i2
      r2 = SyntaxNode.new(input, index...index)
    end
    s1 << r2
    if r2
      if index < input_length
        r6 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure("any character")
        r6 = nil
      end
      s1 << r6
    end
    if s1.last
      r1 = (SyntaxNode).new(input, i1...index, s1)
      r1.extend(Inner0)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r7 = _nt_parens
      if r7
        r0 = r7
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:inner][start_index] = r0

    return r0
  end

  module Prefix0
  end

  module Prefix1
    def caret
      elements[1]
    end
  end

  def _nt_prefix
    start_index = index
    if node_cache[:prefix].has_key?(index)
      cached = node_cache[:prefix][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    i2, s2 = index, []
    if input.index(Regexp.new('[a-zA-Z_]'), index) == index
      r3 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      r3 = nil
    end
    s2 << r3
    if r3
      s4, i4 = [], index
      loop do
        if input.index(Regexp.new('[a-zA-Z0-9_]'), index) == index
          r5 = (SyntaxNode).new(input, index...(index + 1))
          @index += 1
        else
          r5 = nil
        end
        if r5
          s4 << r5
        else
          break
        end
      end
      r4 = SyntaxNode.new(input, i4...index, s4)
      s2 << r4
    end
    if s2.last
      r2 = (SyntaxNode).new(input, i2...index, s2)
      r2.extend(Prefix0)
    else
      self.index = i2
      r2 = nil
    end
    if r2
      r1 = r2
    else
      r1 = SyntaxNode.new(input, index...index)
    end
    s0 << r1
    if r1
      r6 = _nt_caret
      s0 << r6
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(Prefix1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:prefix][start_index] = r0

    return r0
  end

  def _nt_tie
    start_index = index
    if node_cache[:tie].has_key?(index)
      cached = node_cache[:tie][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    if input.index('.', index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure('.')
      r1 = nil
    end
    if r1
      r0 = r1
    else
      if input.index('->', index) == index
        r2 = (SyntaxNode).new(input, index...(index + 2))
        @index += 2
      else
        terminal_parse_failure('->')
        r2 = nil
      end
      if r2
        r0 = r2
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:tie][start_index] = r0

    return r0
  end

  def _nt_caret
    start_index = index
    if node_cache[:caret].has_key?(index)
      cached = node_cache[:caret][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    if index < input_length
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("any character")
      r1 = nil
    end
    if r1
      r0 = nil
    else
      self.index = i0
      r0 = SyntaxNode.new(input, index...index)
    end

    node_cache[:caret][start_index] = r0

    return r0
  end

  def _nt_dec
    start_index = index
    if node_cache[:dec].has_key?(index)
      cached = node_cache[:dec][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    r1 = _nt_std
    if r1
      r0 = r1
    else
      r2 = _nt_declaration
      if r2
        r0 = r2
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:dec][start_index] = r0

    return r0
  end

  module Std0
    def type
      elements[1]
    end

    def template
      elements[2]
    end

    def it
      elements[3]
    end

  end

  module Std1
	def types # key
	    key = :type
		r= template.types
		r[key] = "std::" + type.text_value + it.text_value
		return r
	end
  end

  def _nt_std
    start_index = index
    if node_cache[:std].has_key?(index)
      cached = node_cache[:std][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index("std::", index) == index
      r1 = (SyntaxNode).new(input, index...(index + 5))
      @index += 5
    else
      terminal_parse_failure("std::")
      r1 = nil
    end
    s0 << r1
    if r1
      i2 = index
      if input.index("map", index) == index
        r3 = (SyntaxNode).new(input, index...(index + 3))
        @index += 3
      else
        terminal_parse_failure("map")
        r3 = nil
      end
      if r3
        r2 = r3
      else
        if input.index("vector", index) == index
          r4 = (SyntaxNode).new(input, index...(index + 6))
          @index += 6
        else
          terminal_parse_failure("vector")
          r4 = nil
        end
        if r4
          r2 = r4
        else
          if input.index("queue", index) == index
            r5 = (SyntaxNode).new(input, index...(index + 5))
            @index += 5
          else
            terminal_parse_failure("queue")
            r5 = nil
          end
          if r5
            r2 = r5
          else
            self.index = i2
            r2 = nil
          end
        end
      end
      s0 << r2
      if r2
        r6 = _nt_template
        s0 << r6
        if r6
          if input.index("::iterator", index) == index
            r8 = (SyntaxNode).new(input, index...(index + 10))
            @index += 10
          else
            terminal_parse_failure("::iterator")
            r8 = nil
          end
          if r8
            r7 = r8
          else
            r7 = SyntaxNode.new(input, index...index)
          end
          s0 << r7
          if r7
            s9, i9 = [], index
            loop do
              if input.index("*", index) == index
                r10 = (SyntaxNode).new(input, index...(index + 1))
                @index += 1
              else
                terminal_parse_failure("*")
                r10 = nil
              end
              if r10
                s9 << r10
              else
                break
              end
            end
            r9 = SyntaxNode.new(input, i9...index, s9)
            s0 << r9
          end
        end
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(Std0)
      r0.extend(Std1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:std][start_index] = r0

    return r0
  end

  module Declaration0
    def explicit_space
      elements[1]
    end
  end

  module Declaration1
    def variable
      elements[1]
    end

  end

  module Declaration2
    def explicit_space
      elements[1]
    end
  end

  module Declaration3
    def space
      elements[1]
    end

  end

  module Declaration4
    def var
      elements[1]
    end

    def space
      elements[2]
    end

  end

  module Declaration5
    def types #key
	    key = :type
		return { key => var.elements.text_value }
	end
  end

  def _nt_declaration
    start_index = index
    if node_cache[:declaration].has_key?(index)
      cached = node_cache[:declaration][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    i2, s2 = index, []
    if input.index('const', index) == index
      r3 = (SyntaxNode).new(input, index...(index + 5))
      @index += 5
    else
      terminal_parse_failure('const')
      r3 = nil
    end
    s2 << r3
    if r3
      r4 = _nt_explicit_space
      s2 << r4
    end
    if s2.last
      r2 = (SyntaxNode).new(input, i2...index, s2)
      r2.extend(Declaration0)
    else
      self.index = i2
      r2 = nil
    end
    if r2
      r1 = r2
    else
      r1 = SyntaxNode.new(input, index...index)
    end
    s0 << r1
    if r1
      s5, i5 = [], index
      loop do
        i6, s6 = index, []
        if input.index("::", index) == index
          r8 = (SyntaxNode).new(input, index...(index + 2))
          @index += 2
        else
          terminal_parse_failure("::")
          r8 = nil
        end
        if r8
          r7 = r8
        else
          r7 = SyntaxNode.new(input, index...index)
        end
        s6 << r7
        if r7
          r9 = _nt_variable
          s6 << r9
          if r9
            r11 = _nt_template
            if r11
              r10 = r11
            else
              r10 = SyntaxNode.new(input, index...index)
            end
            s6 << r10
          end
        end
        if s6.last
          r6 = (SyntaxNode).new(input, i6...index, s6)
          r6.extend(Declaration1)
        else
          self.index = i6
          r6 = nil
        end
        if r6
          s5 << r6
        else
          break
        end
      end
      if s5.empty?
        self.index = i5
        r5 = nil
      else
        r5 = SyntaxNode.new(input, i5...index, s5)
      end
      s0 << r5
      if r5
        r12 = _nt_space
        s0 << r12
        if r12
          i14, s14 = index, []
          if input.index('const', index) == index
            r15 = (SyntaxNode).new(input, index...(index + 5))
            @index += 5
          else
            terminal_parse_failure('const')
            r15 = nil
          end
          s14 << r15
          if r15
            r16 = _nt_explicit_space
            s14 << r16
          end
          if s14.last
            r14 = (SyntaxNode).new(input, i14...index, s14)
            r14.extend(Declaration2)
          else
            self.index = i14
            r14 = nil
          end
          if r14
            r13 = r14
          else
            r13 = SyntaxNode.new(input, index...index)
          end
          s0 << r13
          if r13
            s17, i17 = [], index
            loop do
              i18, s18 = index, []
              if input.index("*", index) == index
                r19 = (SyntaxNode).new(input, index...(index + 1))
                @index += 1
              else
                terminal_parse_failure("*")
                r19 = nil
              end
              s18 << r19
              if r19
                r20 = _nt_space
                s18 << r20
                if r20
                  if input.index('const', index) == index
                    r22 = (SyntaxNode).new(input, index...(index + 5))
                    @index += 5
                  else
                    terminal_parse_failure('const')
                    r22 = nil
                  end
                  if r22
                    r21 = r22
                  else
                    r21 = SyntaxNode.new(input, index...index)
                  end
                  s18 << r21
                end
              end
              if s18.last
                r18 = (SyntaxNode).new(input, i18...index, s18)
                r18.extend(Declaration3)
              else
                self.index = i18
                r18 = nil
              end
              if r18
                s17 << r18
              else
                break
              end
            end
            r17 = SyntaxNode.new(input, i17...index, s17)
            s0 << r17
          end
        end
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(Declaration4)
      r0.extend(Declaration5)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:declaration][start_index] = r0

    return r0
  end

  module Variable0
  end

  module Variable1
	def types		 
	end
  end

  def _nt_variable
    start_index = index
    if node_cache[:variable].has_key?(index)
      cached = node_cache[:variable][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index(Regexp.new('[a-zA-Z_]'), index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      r1 = nil
    end
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        if input.index(Regexp.new('[_a-zA-Z0-9]'), index) == index
          r3 = (SyntaxNode).new(input, index...(index + 1))
          @index += 1
        else
          r3 = nil
        end
        if r3
          s2 << r3
        else
          break
        end
      end
      r2 = SyntaxNode.new(input, i2...index, s2)
      s0 << r2
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(Variable0)
      r0.extend(Variable1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:variable][start_index] = r0

    return r0
  end

  module Template0
    def val
      elements[1]
    end
  end

  module Template1
    def first
      elements[0]
    end

    def following
      elements[1]
    end
  end

  module Template2
    def contains
      elements[1]
    end

  end

  module Template3
	def types
		r = {}
		if contains.elements
			r[1] = contains.elements.first.types 
			i = 2
			contains.following.elements.each {|e| r[i] =e.val.types; i+=1} if contains.following.elements
		end
		return r
	end
  end

  def _nt_template
    start_index = index
    if node_cache[:template].has_key?(index)
      cached = node_cache[:template][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index('<', index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure('<')
      r1 = nil
    end
    s0 << r1
    if r1
      i3, s3 = index, []
      r4 = _nt_dec
      s3 << r4
      if r4
        s5, i5 = [], index
        loop do
          i6, s6 = index, []
          if input.index(',', index) == index
            r7 = (SyntaxNode).new(input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure(',')
            r7 = nil
          end
          s6 << r7
          if r7
            r8 = _nt_dec
            s6 << r8
          end
          if s6.last
            r6 = (SyntaxNode).new(input, i6...index, s6)
            r6.extend(Template0)
          else
            self.index = i6
            r6 = nil
          end
          if r6
            s5 << r6
          else
            break
          end
        end
        r5 = SyntaxNode.new(input, i5...index, s5)
        s3 << r5
      end
      if s3.last
        r3 = (SyntaxNode).new(input, i3...index, s3)
        r3.extend(Template1)
      else
        self.index = i3
        r3 = nil
      end
      if r3
        r2 = r3
      else
        r2 = SyntaxNode.new(input, index...index)
      end
      s0 << r2
      if r2
        if input.index('>', index) == index
          r9 = (SyntaxNode).new(input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure('>')
          r9 = nil
        end
        s0 << r9
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(Template2)
      r0.extend(Template3)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:template][start_index] = r0

    return r0
  end

  module String0
  end

  module String1
  end

  def _nt_string
    start_index = index
    if node_cache[:string].has_key?(index)
      cached = node_cache[:string][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index('"', index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure('"')
      r1 = nil
    end
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        i3 = index
        i4, s4 = index, []
        i5 = index
        if input.index('"', index) == index
          r6 = (SyntaxNode).new(input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure('"')
          r6 = nil
        end
        if r6
          r5 = nil
        else
          self.index = i5
          r5 = SyntaxNode.new(input, index...index)
        end
        s4 << r5
        if r5
          if index < input_length
            r7 = (SyntaxNode).new(input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure("any character")
            r7 = nil
          end
          s4 << r7
        end
        if s4.last
          r4 = (SyntaxNode).new(input, i4...index, s4)
          r4.extend(String0)
        else
          self.index = i4
          r4 = nil
        end
        if r4
          r3 = r4
        else
          if input.index('\"', index) == index
            r8 = (SyntaxNode).new(input, index...(index + 2))
            @index += 2
          else
            terminal_parse_failure('\"')
            r8 = nil
          end
          if r8
            r3 = r8
          else
            self.index = i3
            r3 = nil
          end
        end
        if r3
          s2 << r3
        else
          break
        end
      end
      r2 = SyntaxNode.new(input, i2...index, s2)
      s0 << r2
      if r2
        if input.index('"', index) == index
          r9 = (SyntaxNode).new(input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure('"')
          r9 = nil
        end
        s0 << r9
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(String1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:string][start_index] = r0

    return r0
  end

  def _nt_space
    start_index = index
    if node_cache[:space].has_key?(index)
      cached = node_cache[:space][index]
      @index = cached.interval.end if cached
      return cached
    end

    s0, i0 = [], index
    loop do
      if input.index(Regexp.new('[ ]'), index) == index
        r1 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        r1 = nil
      end
      if r1
        s0 << r1
      else
        break
      end
    end
    r0 = SyntaxNode.new(input, i0...index, s0)

    node_cache[:space][start_index] = r0

    return r0
  end

  def _nt_explicit_space
    start_index = index
    if node_cache[:explicit_space].has_key?(index)
      cached = node_cache[:explicit_space][index]
      @index = cached.interval.end if cached
      return cached
    end

    s0, i0 = [], index
    loop do
      if input.index(Regexp.new('[ ]'), index) == index
        r1 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        r1 = nil
      end
      if r1
        s0 << r1
      else
        break
      end
    end
    if s0.empty?
      self.index = i0
      r0 = nil
    else
      r0 = SyntaxNode.new(input, i0...index, s0)
    end

    node_cache[:explicit_space][start_index] = r0

    return r0
  end

  def _nt_other
    start_index = index
    if node_cache[:other].has_key?(index)
      cached = node_cache[:other][index]
      @index = cached.interval.end if cached
      return cached
    end

    if index < input_length
      r0 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("any character")
      r0 = nil
    end

    node_cache[:other][start_index] = r0

    return r0
  end

end

class CppParser < Treetop::Runtime::CompiledParser
  include Cpp
end
