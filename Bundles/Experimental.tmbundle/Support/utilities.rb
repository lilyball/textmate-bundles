#!/usr/bin/env ruby -w

# HTML Utilities for TextMate v.beta
# Michael Sheets - Sept 27, 2005
# 
# Special thanks to allan for listening to my regex whining :)

def strip_tags(html)
  # First we need to get rid of any embedded code.
  html = strip_embedded(html)

  # Remove comments
  html = html.gsub(/<!--.*?--\s*>/m, "\xEF\xBF\xBC")

  # SGML Declarations
  html = html.gsub(/<!.*?>/m, "\xEF\xBF\xBC")

  # Remove script and css blocks
  html = html.gsub(/<script.*?>.*?<\/script>/m, "\xEF\xBF\xBC")
  html = html.gsub(/<style.*?>.*?<\/style>/m, "\xEF\xBF\xBC")

  # Strip html tags
  html = html.gsub(/<\/?                      # opening tag with optional slash
                      (
                        [^<>"']         |     # match anything unquoted
                        ".*?"           |     # match double quotes…
                        '.*?'                 # and single ones
                      )*                      # any combination of the three
                    >                         # close tag
                   /xm, "\xEF\xBF\xBC")       # placeholder

  # Handle placeholders
  html = html.gsub(/^[ \t]*\xEF\xBF\xBC[ \t]*(\n|\r|\r\n)/xm, '')  # Remove lines with only tags
  html = html.gsub(/\xEF\xBF\xBC/xm, '')                           # Remove other placeholders
end

def html2text(html, script_path)
  # First we need to get rid of any embedded code.
  html = strip_embedded(html)

  # Send to html2text.py
  html = `#{script_path} #{html}`
end


private

def strip_embedded(html)
  # Ruby and some PHP
  html = html.gsub(/<%(?!%)
                      (?>                             # opening tag (negate is for an
                                                      #  escaped char)
                        <<<([a-zA-Z_][a-zA-Z0-9_]*).*?^\2;?$  |
                                                      # php heredoc, hopefully doesn't
                                                      #  colide with erb
                        %(?!>)                    |   # match any % that's not an end tag
                        [^"'%]                    |   # match everything else, except strings
                        "(\\("|\\)|[^"])*"        |   # double quoted strings…
                        '(\\('|\\)|[^'])*'            # …and single
                      )
                    %>                                # close tag
                   /xm, "\xEF\xBF\xBC")
  # PHP
  html = html.gsub(/<\?(php|=)?                       # opening tag with optional php or =
                      (?>
                        \/\*.*?\*\/               |   # block comments
                        <<<([a-zA-Z_][a-zA-Z0-9_]*).*?^\2;?$  |
                                                      # heredoc
                        \?(?!>)                   |   # match any ? that's not an end tag
                        [^"'?]                    |   # match everything else, except strings
                        "(\\("|\\)|[^"])*"        |   # double quoted strings…
                        '(\\('|\\)|[^'])*'            # …and single
                      )*
                    \?>                               # close tag
                   /xm, "\xEF\xBF\xBC")
  html = html.gsub(/<script language=['"]php['"].*?\/script>/m, "\xEF\xBF\xBC")
  # Movable Type
  html = html.gsub(/<\$MT.*?\$>/m, "\xEF\xBF\xBC")
  html = html.gsub(/<\/?MT.*?>/m, "\xEF\xBF\xBC")

  # Handle placeholders
  html = html.gsub(/^[ \t]*\xEF\xBF\xBC[ \t]*(\n|\r|\r\n)/xm, '')  # Remove lines with only tags
  html = html.gsub(/\xEF\xBF\xBC/xm, '')                           # Remove other placeholders
end







