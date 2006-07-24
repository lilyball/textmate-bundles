# Module for S5 presenation; S5 by Eric Meyer; module by Brad Choate

require "#{ENV['TM_SUPPORT_PATH']}/lib/bluecloth.rb"
require "#{ENV['TM_SUPPORT_PATH']}/lib/rubypants.rb"

class S5 < String
  DIVIDER = '✂------'
  HANDOUT = '__________'
  NOTES = '##########'

  attr_reader :title, :subtitle, :location, :presenter, :organization,
    :date, :slides, :theme, :defaultView, :controlVis, :current_slide_number

  private

  def parse
    @slides = []
    headers = {}

    in_headers = true

    lines = split(/\n/)
    current_line = ENV['TM_LINE_NUMBER'].to_i if ENV['TM_LINE_NUMBER']
    current_line ||= 0
    slide = ''
    line_num = 0
    slide_num = 0

    lines.each do | line |
      line_num += 1
      if line_num == current_line
        @current_slide_number = slide_num + 1
      end

      if in_headers
        if line =~ /^(\w+):[ ]*(.+)/
          headers[$1] = $2
        else
          @current_slide_number = nil
          in_headers = false
        end
        next
      else
        if line =~ %r{^(#{DIVIDER})+}
          if slide.strip != ''
            slide_num += 1
            @slides.push(slide)
          end
          slide = ''
          next
        end
      end
      slide += line + "\n"
    end
    @slides.push(slide) unless slide.strip.empty?
    @current_slide_number = slide_num + 1 unless @current_slide_number

    require 'cgi'
    # set values for template
    @title = RubyPants.new(CGI::escapeHTML("#{headers['Title']}")).to_html
    @date = headers['Date']
    @subtitle = RubyPants.new(CGI::escapeHTML("#{headers['Subtitle']}")).to_html
    @location = RubyPants.new(CGI::escapeHTML("#{headers['Location']}")).to_html
    @presenter = RubyPants.new(CGI::escapeHTML("#{headers['Presenter'] || headers['Author']}")).to_html
    @organization = RubyPants.new(CGI::escapeHTML("#{headers['Organization'] || headers['Company']}")).to_html
    @theme = headers['Theme'] || 'default'
    @defaultView = headers['View'] || 'slideshow'
    @controlVis = headers['Controls'] || 'visible'
  end

  public

  def to_html
    s5tmpl = IO.readlines(ENV["TM_BUNDLE_SUPPORT"] + "/s5.tmpl").join

    s5tmpl =~ /##SLIDE_START(.+)##SLIDE_END/m
    slide_tmpl = $1

    # merge str and s5tmpl

    parse()

    # read in input; process headers and split slides

    # TM_DIRECTORY / TM_PROJECT_DIRECTORY

    @organization ||= ENV['TM_ORGANIZATION_NAME'] if ENV['TM_ORGANIZATION_NAME']

    # file directory
    path = nil
    if ENV['TM_DIRECTORY']
      path = '.' if File.directory?(ENV['TM_DIRECTORY'] + '/ui/' + theme)
    end
    if !path && ENV['TM_PROJECT_DIRECTORY']
      path = 'file://' + ENV['TM_PROJECT_DIRECTORY'] if File.directory?(ENV['TM_PROJECT_DIRECTORY'] + '/ui' + theme)
    end
    if !path
      path = 'file://' + ENV['TM_BUNDLE_SUPPORT']
      @theme = 'default'
    end

    theme_base = path

    content = nil
    handout = nil
    notes = nil
    all_slides = ''
    self.slides.each do | slide |
      if slide =~ %r{^#{HANDOUT}$}m
        parts = slide.split(%r{^#{HANDOUT}$})
        content = parts[0]
        handout = parts[1]
        if handout =~ %r{^#{NOTES}$}m
          parts = handout.split(%r{^#{NOTES}$})
          handout = parts[0]
          notes = parts[1]
        end
        if content =~ %r{^#{NOTES}$}m
          parts = content.split(%r{^#{NOTES}$})
          content = parts[0]
          notes = parts[1]
        end
      elsif slide =~ %r{^#{NOTES}$}m
        parts = slide.split(%r{^#{NOTES}$})
        content = parts[0]
        notes = parts[1]
      else
        content = slide
        handout = nil
        notes = nil
      end
      content = RubyPants.new(BlueCloth.new(content).to_html).to_html
      notes = RubyPants.new(BlueCloth.new(notes).to_html).to_html unless notes.nil?
      handout = RubyPants.new(BlueCloth.new(handout).to_html).to_html unless handout.nil?

      all_slides += eval '%Q{' + slide_tmpl + '}'
    end
    s5tmpl.sub!(/##SLIDE_START.+##SLIDE_END/m, all_slides)
    s5tmpl = eval '%Q{' + s5tmpl + '}'

    return s5tmpl
  end
end