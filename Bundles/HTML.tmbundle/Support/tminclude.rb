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

      def parse_arguments(arg_str, vars)
        arg_str.scan(@@argument_regexp) do | var, quote, val, val2 |
          vars[var.downcase] = val.nil? ? val2 : val
        end
      end

      def replace_variables(content, vars)
        content.gsub(/(#(?:(?:\w| )+?)#)/) do | expr |
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
            out.arity == 0 ? out.call : out.call(attribute)
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
        @@global_vars['localpath'] = ENV['TM_FILEPATH']
        @@global_vars['shortusername'] = ENV['USER']
        # lazily invoke this one, since it has cost associated with it...
        @@global_vars['username'] = method("var_username")

        # abbrev_date # format: Sun, Aug 15, 2004
        # base
        # basename # 'test' for file test.html; 'test.foo' for test.foo.html
        # base_url, bodytext, charset,
        # compdate # format: 15-Aug-04
        # creationdate # format: 15-Aug-04
        # creationtime
        # dirpath, docsize, doctitle, dont_update, file_extension, filename,
        # generator, gmtime, language, link, localtime, longdate, machine,
        # meta, modifieddate, modifiedtime, monthdaynum, path, prefix,
        # real_url, relative, root, rootpath, server, shortdate, 
        # time, title, yearnum
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
        init_global_vars()
        doc = STDIN.readlines.join
        @@depth = 1
        print process_document(doc, vars)
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