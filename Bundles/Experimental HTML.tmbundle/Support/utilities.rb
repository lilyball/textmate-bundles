#!/usr/bin/env ruby -w

def strip_tags(html)
  # First we need to get rid of any embedded code.
  html = strip_embedded(html)

  # Remove comments
  html = html.gsub(/<!--.*?--\s*>/m, '')

  # SGML Declarations
  html = html.gsub(/<!.*?>/m, '')

  # Strip html tags
  html = html.gsub(/<\/?                      # opening tag with optional slash
                      (
                        [^>"']+         |     # match anything unquoted
                        ".*?"           |     # match double quotes…
                        '.*?'                 # and single ones
                      )*                      # any combination of the three
                    >                         # close tag
                   /xm, '')
end

def html2text(html, script_path)
  # First we need to get rid of any embedded code.
  html = strip_embedded(html)

  # Send to html2text.py
  html = `#{script_path} #{html}`
end


private

def strip_embedded(html)
  # Ruby (and some php)
  html = html.gsub(/<%(?!%).*?%>/m, '')
  # PHP
  #html = html.gsub(/<\?(php|=)?.*?\?>/m, '')
  html = html.gsub(/<\?(php|=)?                       # opening tag with optional php or =
                      (
                        \/\*.*?\*\/               |   # block comments
                        <<<([a-zA-Z]+[a-zA-Z0-9_]*).*?^\5;?$  |
                                                      # heredoc
                        <(?!<<)                   |   # match any < that's not a heredoc
                        \?(?!>)                   |   # match any ? that's not an end tag
                        [^<"'?]                   |   # match everything else, except strings
                        "(\\("|\\)|[^"])*"        |   # double quoted strings…
                        '(\\('|\\)|[^'])*'            # …and single
                      )*
                    \?>                               # close tag
                   /xm, '')
  html = html.gsub(/<script language=['"]php['"].*?\/script>/m, '')
  # Movable Type
  html = html.gsub(/<\$MT.*?\$>/m, '')
  html = html.gsub(/<\/?MT.*?>/m, '')
end







