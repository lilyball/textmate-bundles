# tminclude.rb
#
# An implementation of "Persistent Includes" for TextMate
# Brad Choate <brad@bradchoate.com> 

module TextMate
  module Includes
    class << self
      # non-capturing for .gsub
      # <!-- #tminclude "/path/to/file" -->
      # <!-- #tminclude "/path/to/file" #arg#="value" ... -->
      @@tminclude_regexp = %r{<!--\s*#(?:tm|bb)include\s.*?-->.+?<!--\s*end (?:tm|bb)include\s*-->}im
      # version that captures for .scan
      @@tminclude_regexp_detail = %r{(<!--\s*#(?:tm|bb)include\s+['"]([^'"]+)['"](?:\s+(.*?))?-->)(.+?)(<!--\s*end (?:tm|bb)include\s*-->)}im
      # #arg#="value"
      @@argument_regexp = /\s*#([^#]+?)#\s*=\s*(?:(["'])([^\2]*?)\2|(\S+))\s*/m
      @@depth = 0
      @@global_vars = {}
      @@time = Time.now
      @@ctime = nil
      @@mtime = nil

      def parse_arguments(arg_str, vars)
        arg_str.scan(@@argument_regexp) do | var, quote, val, val2 |
          vars[var.downcase] = val.nil? ? val2 : val
        end
      end

      def replace_variables(content, vars)
        content.gsub(/(#\w+(?:\s+[^#]+?)?#)/m) do | expr |
          # normalize variable... strip '#' prefix/suffix/parameter, downcase
          var = expr.gsub(/^\#|\#$/, '')
          if var =~ / +(.+)/
            attribute = $1
            var.sub!(/ .+/, '')
          else
            attribute = nil
          end
          var.downcase!
          out = vars[var] || @@global_vars[var] || expr
          if out.kind_of?(Method)
            case out.arity
              when 0
                out.call
              when 1
                out.call(attribute)
              when -1
                attribute.nil? ? out.call : out.call(attribute)
              else
                expr
            end
          else
            out
          end
        end
      end

      def invoke_interpreter(file, vars)
        require "#{ENV['TM_SUPPORT_PATH']}/lib/escape.rb"
        # run interpreter using file and requested arguments
        filepath = e_sh(ENV['TM_FILEPATH'] || '/dev/null')
        argstr = ''
        vars.each_pair { | k, v | argstr << " " << e_sh(k) << " " << e_sh(v) }
        %x{#{file} #{filepath}#{argstr}};
      end

      def process_include(file, args, vars)
        @@doc_stack ||= Hash.new

        local_vars = vars.dup
        @@depth += 1

        content = nil

        # File resolution; expand ~/... paths;
        # look for relative files, relative to current file, current project
        file = File.expand_path(file)
        if File.exist?(filepath = file)
        elsif file.match(/^\//) # non-relative path...
          print "Could not open file: #{file}"
          exit 206
        elsif File.exist?(filepath = "#{ENV['TM_FILEPATH']}/#{file}")
        elsif File.exist?(filepath = "#{ENV['TM_PROJECT_DIRECTORY']}/#{file}")
        else
          print "Could not open file: #{file}"
          exit 206
        end

        if @@doc_stack.has_key?(file)
          print "Error: recursive include for #{file}"
          exit 206
        end

        @@doc_stack[file] = true

        parse_arguments(args, local_vars) unless args.nil?
        if File.executable?(file) and file.match(/\.(pl|rb|py)$/)
          content = invoke_interpreter(file, local_vars)
        else
          content = IO.readlines(file).join
        end
        replace_variables(content, local_vars)
        if content.scan(@@tminclude_regexp)
          content = process_document(content, local_vars)
        end

        @@doc_stack.delete(file)

        @@depth -= 1
        content
      end

      def init_global_vars
        @@global_vars = {}
        # start by setting all the TM_* defined variables
        ENV.each_pair do | k, v |
          if k =~ /^TM_(.+)/
            @@global_vars[$1.downcase] = v
          end
        end
        # Here are some of BBEdit's global variables. We may choose
        # to cherry pick these for support...
        @@global_vars['dont_update'] = ''
        @@global_vars['localpath'] = ENV['TM_FILEPATH']
        @@global_vars['shortusername'] = ENV['USER']
        # lazily invoke this one, since it has cost associated with it...
        @@global_vars['username'] = method("var_username")

        @@global_vars['localtime'] = method("var_localtime")
        @@global_vars['gmtime'] = method("var_gmtime")
        @@global_vars['longdate'] = @@time.strftime("%A, %B %e, %Y").sub(/  /, ' ')
        @@global_vars['compdate'] = @@time.strftime("%d-%b-%y")
        @@global_vars['monthnum'] = @@time.strftime("%m")
        @@global_vars['monthdaynum'] = @@time.strftime("%d")
        @@global_vars['shortdate'] = @@time.strftime("%m/%d/%y").gsub(/0(\d\/)/, '\1')
        @@global_vars['abbrevdate'] = @@time.strftime("%a, %b %e, %Y").sub(/  /, ' ')
        @@global_vars['yearnum'] = @@time.year
        @@global_vars['generator'] = "TextMate"

        if filename = ENV['TM_FILENAME']
          @@global_vars['filename'] = filename
          @@global_vars['basename'] = filename.sub(/\.\w+$/, '')
          if filename =~ /(\.\w+$)/
            @@global_vars['file_extension'] = $1
          else
            @@global_vars['file_extension'] = ''
          end

          if ctime = File.ctime(ENV['TM_FILEPATH'])
            @@ctime = ctime
            @@global_vars['creationdate'] = method('var_creationdate')
            @@global_vars['creationtime'] = method('var_creationtime')
          end
          if mtime = File.mtime(ENV['TM_FILEPATH'])
            @@mtime = mtime
            @@global_vars['modifieddate'] = method('var_modifieddate')
            @@global_vars['modifiedtime'] = method('var_modifiedtime')
          end
        end

        # Unsupported...
        # base, base_url, bodytext, charset, dirpath, doctitle, language,
        # link, machine, meta, path, prefix, real_url, relative, root,
        # rootpath, server, title
      end

      # Dynamic variables

      def var_creationtime(format = "%l:%M %p")
        @@ctime ? @@ctime.strftime(format) : nil
      end

      def var_creationdate(format = "%d-%b-%y")
        @@ctime ? @@ctime.strftime(format) : nil
      end

      def var_modifiedtime(format = "%l:%M %p")
        @@mtime ? @@mtime.strftime(format) : nil
      end

      def var_modifieddate(format = "%d-%b-%y")
        @@mtime ? @@mtime.strftime(format) : nil
      end

      def var_localtime(format = "%c")
        @@time.strftime(format)
      end

      def var_gmtime(format = "%c")
        @@time.gmtime.strftime(format)
      end

      def var_username
        # store the username into the variable stash so we don't have
        # to do this again...
        @@global_vars['username'] = "#{%x{niutil -readprop / /users/#{ENV['USER']} realname}}".chomp
      end

      def process_document(doc, vars)
        # process blocks that look like this:
        # <!-- #tminclude "/path/to/file" -->
        # <!-- end tminclude -->
        # and this...
        # <!-- #tminclude "/path/to/file" #param#="value" #param2="value" -->
        # <!-- end tminclude -->
        doc.gsub!(@@tminclude_regexp) do | match |
          result = match
          match.scan(@@tminclude_regexp_detail) do | open, file, args, incl, close |
            if @@depth == 1
              result = "#{open}#{process_include(file, args, vars)}#{close}"
            else
              result = "#{process_include(file, args, vars)}"
            end
          end
          result
        end
        replace_variables(doc, vars)
      end

      def process_persistent_includes
        vars = {}
        doc = STDIN.readlines.join
        @@depth = 1
        init_global_vars()
        if doc =~ /\#dont_update\#/
          print "This document cannot be updated because it is protected."
          exit 206
        end
        doc = process_document(doc, vars)

        # lastly, process '#docsize#'
        # TBD: support for reporting document size in kb, mb, etc.
        # TBD: support for image sizes as well.
        matches = doc.scan(/#docsize#/i)
        if matches.length
          # baselen is document without any "#docsize#" elements
          baselen = doc.length - '#docsize#'.length * matches.length
          # newlen is document with added docsize values
          newlen = baselen + baselen.to_s.length * matches.length
          # sometimes this adjustment causes the length of the document
          # to change again, so check for that.
          while baselen + (newlen.to_s.length * matches.length) != newlen
            newlen = baselen + (newlen.to_s.length * matches.length)
          end
          doc.gsub!(/#docsize#/i, newlen.to_s)
        end
        print doc
      end

      def include_command
        require "#{ENV['TM_SUPPORT_PATH']}/lib/dialog.rb"
        begin
          Dialog.request_file do | file |
            print <<-"EOT"
<!-- #tminclude "#{file}" -->
<!-- end tminclude -->
EOT
          end
        rescue SystemExit
          exit 200
        end
      end
    end
  end
end