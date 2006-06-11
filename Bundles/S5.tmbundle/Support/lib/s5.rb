# Module for S5 presenation; S5 by Eric Meyer; module by Brad Choate

require "#{ENV['TM_BUNDLE_SUPPORT']}/lib/bluecloth.rb"
require "#{ENV['TM_BUNDLE_SUPPORT']}/lib/rubypants.rb"

class S5 < String
  DIVIDER = '✂------'
  HANDOUT = '__________'

  attr_reader :title, :subtitle, :location, :presenter, :organization,
    :date, :slides, :theme, :defaultView, :controlVis

  private

  def _parse
    @slides = []
    _headers = {}

    _in_headers = true

    _lines = split(/\n/)
    _slide = ''
    _lines.each do | _line |
      if _in_headers
        if _line =~ /^(\w+):[ ]*(.+)/
          _headers[$1] = $2
        else
          _in_headers = false
        end
        next
      else
        if (_line =~ %r{^(#{DIVIDER})+})
          if _slide.strip != ''
            @slides.push(_slide)
          end
          _slide = ''
          next
        end
      end
      _slide += _line + "\n"
    end
    if _slide.strip != ''
      @slides.push(_slide)
    end

    # set values for template
    @title = _headers['Title']
    @date = _headers['Date']
    @subtitle = _headers['Subtitle']
    @location = _headers['Location']
    @presenter = _headers['Presenter'] || _headers['Author']
    @organization = _headers['Organization'] || _headers['Company']
    @theme = _headers['Theme'] || 'default'
    @defaultView = _headers['View'] || 'slideshow'
    @controlVis = _headers['Controls'] || 'visible'
  end

  public

  def to_html
    _s5tmpl = IO.readlines(ENV["TM_BUNDLE_SUPPORT"] + "/s5.tmpl").join

    _s5tmpl =~ /##SLIDE_START(.+)##SLIDE_END/m
    _slide_tmpl = $1

    # merge str and s5tmpl

    _parse

    # read in input; process headers and split slides

    # TM_DIRECTORY / TM_PROJECT_DIRECTORY

    @organization ||= ENV['TM_ORGANIZATION_NAME'] if ENV['TM_ORGANIZATION_NAME']

    # file directory
    _path = nil
    if ENV['TM_DIRECTORY']
      _path = '.' if File.directory?(ENV['TM_DIRECTORY'] + '/ui/' + theme)
    end
    if !_path && ENV['TM_PROJECT_DIRECTORY']
      _path = 'file://' + ENV['TM_PROJECT_DIRECTORY'] if File.directory?(ENV['TM_PROJECT_DIRECTORY'] + '/ui' + theme)
    end
    if !_path
      _path = 'file://' + ENV['TM_BUNDLE_SUPPORT']
      @theme = 'default'
    end

    theme_base = _path

    content = nil
    handout = nil
    _slides = ''
    slides.each do | _slide |
      if _slide =~ %r{^#{HANDOUT}$}m
        _parts = _slide.split(%r{^#{HANDOUT}$})
        content = _parts[0]
        handout = _parts[1]
      else
        content = _slide
        handout = nil
      end
      content = RubyPants.new(BlueCloth.new(content).to_html).to_html
      _slides += eval '%Q{' + _slide_tmpl + '}'
    end
    _s5tmpl.sub!(/##SLIDE_START.+##SLIDE_END/m, _slides)
    _s5tmpl = eval '%Q{' + _s5tmpl + '}'

    return _s5tmpl
  end
end