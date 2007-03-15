#/usr/local/bin/ruby

##
# Ruby API for Yahoo! Search Web Services
# See http://developer.yahoo.net/
# (C) 2005 Premshree Pillai
# http://www.livejournal.com/~premshree
#
# LICENSE: BSD(-compatible)
#
# EXAMPLE:
#  - <tt>obj = WebSearch.new('YOUR-APP_ID', 'query')</tt>
#  - <tt>obj.parse_results</tt> #returns a result hash
#
# see code to understand stuff
#
# HISTORY:
#  - 0.2 JUN-29-2005:
#	- MyWeb2 support (tag search, url search, related tags)
#  - 0.1 MAR-01-2005: Initial release
#
# BUGS? premshree at gmail dot com
#
# TODO:
#  - Clean-up code
#  - Refactor
#  - Change complete design?
##

require 'net/http'
require 'rexml/document'
include REXML

$AUTHOR = "Premshree Pillai"
$VERSION = "0.2"
$DATE = "2005-06-29 10:12"

$SERVICES = {
	    'video_search' => ['VideoSearchService', 'videoSearch', 'Video Search'],
            'image_search' => ['ImageSearchService', 'imageSearch', 'Image Search'],
            'web_search' => ['WebSearchService', 'webSearch', 'Web Search'],
            'news_search' => ['NewsSearchService', 'newsSearch', 'News Search'],
            'web_related' => ['WebSearchService', 'relatedSuggestion', 'Web Search Related Suggestion'],
            'spelling' => ['WebSearchService', 'spellingSuggestion', 'Web Search Spelling Suggestion'],
	    'myweb2_url'	=> ['MyWebService', 'urlSearch', 'URL search'],
	    'myweb2_tag'	=> ['MyWebService', 'tagSearch', 'Tag search'],
	    'myweb2_related'	=> ['MyWebService', 'relatedTags', 'Related tags'],
	    'tag_analysis' => ['ContentAnalysisService', 'termExtraction', 'Tag Analysis']
}

class Search
    def initialize(app_id)
	@NAME = "Search"
	@SERVICE = "Search"
	@PROTOCOL = "http"
	@SERVER = "api.search.yahoo.com"
	@VERSION = "V1"
	@NEXT_QID = 1

        #super(_Search, self).__init__(debug)
        @service = { "name" => @NAME,
                      "protocol" => @PROTOCOL,
                      "server" => @SERVER,
                      "version" => @VERSION,
                      "service" => @SERVICE }

        @app_id = app_id
        @valid_params = {}

        @qid = @NEXT_QID
        @NEXT_QID = @NEXT_QID + 1

        init_valid_params()
        reset()
    end

    def init_valid_params()
	# todo
    end

    def reset()
        @params = {}
        @url = nil
    end

    def get_svc_name()
        return @service["name"]
    end
    def set_svc_name(value)
        @service["name"] = value
    end

    def get_svc_protocol()
        return @service["protocol"]
    end
    def set_svc_protocol(value)
        @service["protocol"] = value
    end

    def get_svc_service()
        return @service["service"]
    end
    def set_svc_service(value)
        @service["service"] = value
    end

    def get_svc_server()
        return @service["server"]
    end
    def set_svc_server(value)
        @service["server"] = value
    end

    def get_svc_version()
        return @service["version"]
    end
    def set_svc_version(value)
        @service["version"] = value
    end

    def get_app_id()
        return @app_id
    end
    def set_app_id(app_id)
        if app_id.class.to_s == 'String' and app_id =~ /^[a-zA-Z0-9 _()\[\]*+\-=,.:\\\@]{8,40}$/
	    begin
                @app_id = app_id
		#update(@params, {'app_id' => @app_id})
	    rescue
		p "'app_id' can only contain a-zA-Z0-9 _()\[\]*+\-=,.:\\\@"
	    end
	end
    end

    def set_params(args)
	 args.each { |param, value|
	    set_param(param, value)
	 }
    end

    def get_param(param)
        if @params.keys.include?(param)
            return @params[param]
        else
            return @valid_params[param][1]
	end
    end

    def set_param(param, value)
    	@params[param] = value
    end

    def update(var, hsh)
	hsh.each { |param, value|
	    var[param] = value
	}
    end
    def encode_params()
    	encoded_params = ''
	@params.each { |param, value|
	    encoded_params = encoded_params + "#{param}=#{value}&"
	}
	return encoded_params
    end

    def get_valid_params()
        return @valid_params.keys
    end

    def get_url()
        params = @params
        update(@params, {"appid" => @app_id})
        @url = "#{@service['protocol']}://#{@service['server']}/#{@service['service']}/#{@service['version']}/#{@service['name']}?" + encode_params
        return @url
    end

    def open()
        url = get_url()
	#p url
	resp = Net::HTTP.get_response(URI.parse(url))
	@data = resp.body
        return @data
    end
    def parse_analysis()
      open()
      doc = Document.new(@data)
      results = []
      doc.elements.each('ResultSet/Result') {|element|
        results << element.text
      }
      return results
    end
    def parse_results()
    	open()
	xml_string = @data
	doc = Document.new(xml_string)
	results = []
	results_nos = []
	results_titles = []
	results_summaries = []
	results_urls = []
	results_clickurls = []
	results_moddates = []
	results_mimetypes = []

	# myweb2
	results_users = []
	results_notes = []
	results_dates = []
	results_tags = []
	results_freqs = []

	doc.elements.each('ResultSet/Result') { |element|
			results_nos << ''
	}
	doc.elements.each('ResultSet/Result/Title') { |element|
			results_titles << element.text
	}
	doc.elements.each('ResultSet/Result/Summary') { |element|
			results_summaries << element.text
	}
	doc.elements.each('ResultSet/Result/Url') { |element|
			results_urls << element.text
	}
	doc.elements.each('ResultSet/Result/ClickUrl') { |element|
			results_clickurls << element.text
	}
	doc.elements.each('ResultSet/Result/ModificationDate') { |element|
			results_moddates << element.text
	}
	doc.elements.each('ResultSet/Result/MimeType') { |element|
			results_mimetypes << element.text
	}
	doc.elements.each('ResultSet/Result/User') { |element|
			results_users << element.text
	}
	doc.elements.each('ResultSet/Result/Note') { |element|
			results_notes << element.text
	}
	doc.elements.each('ResultSet/Result/Date') { |element|
			results_dates << element.text
	}
	doc.elements.each('ResultSet/Result/Tag') { |element|
			results_tags << element.text
	}
	doc.elements.each('ResultSet/Result/Frequency') { |element|
			results_freqs << element.text
	}
	count = 0
	results_nos.length.times {
		# TODO: return keys that have values
		results << {
			'Title' => results_titles[count],
			'Summary' => results_summaries[count],
			'Url' => results_urls[count],
			'ClickUrl' => results_clickurls[count],
			'ModificationDate' => results_moddates[count],
			'MimeType' => results_mimetypes[count],
			'User' => results_users[count],
			'Note' => results_notes[count],
			'Date' => results_dates[count],
			'Tag' => results_tags[count],
			'Frequency' => results_freqs[count],
		}
		count = count + 1
	}
	return results
    end

    # basic parameters
    def get_query()
        return get_param("query")
    end
    def set_query(value)
        set_param("query", value)
    end
    
    def set_context(value)
        set_param("context", value)
    end

    def get_results()
        return get_param("results")
    end
    def set_results(value)
        set_param("results", value)
    end

    def get_start()
        return get_param("start")
    end
    def set_start(value)
        set_param("start", value)
    end

    def set_tag(value)
        set_param("tag", value)
    end

    def set_yid(value)
        set_param("yid", value)
    end

    def set_sort(value)
        set_param("sort", value)
    end

    def set_reverse_sort(value)
        set_param("reverse_sort", value)
    end

    def set_url(value)
        set_param("url", value)
    end

    # common params
    def get_type()
        return get_param("type")
    end
    def set_type(value)
        set_param("type", value)
    end

    def get_format()
        return get_param("format")
    end
    def set_format(value)
        set_param("format", value)
    end

    def get_adult_ok()
        return get_param("adult_ok")
    end
    def set_adult_ok(value)
        set_param("adult_ok", value)
    end
end



class VideoSearch < Search
    def initialize(app_id, query, type='all', results=10, start=1, format=nil, adult_ok=0)
        super Search
    	set_app_id(app_id)
    	set_svc_service($SERVICES['video_search'][0])
	set_svc_name($SERVICES['video_search'][1])
	set_query(query)
	set_type(type)
	set_results(results)
	set_start(start)
	set_format(format)
	set_adult_ok(adult_ok)
    end
end



class ImageSearch < Search
    def initialize(app_id, query, type='all', results=10, start=1, format=nil, adult_ok=0)
        super Search
    	set_app_id(app_id)
    	set_svc_service($SERVICES['image_search'][0])
	set_svc_name($SERVICES['image_search'][1])
	set_query(query)
	set_type(type)
	set_results(results)
	set_start(start)
	set_format(format)
	set_adult_ok(adult_ok)
    end
end



class WebSearch < Search
    def initialize(app_id, query, type='all', results=10, start=1, format=nil, adult_ok=0)
        super Search
    	set_app_id(app_id)
    	set_svc_service($SERVICES['web_search'][0])
	set_svc_name($SERVICES['web_search'][1])
	set_query(query)
	set_type(type)
	set_results(results)
	set_start(start)
	set_format(format)
	set_adult_ok(adult_ok)
    end

    def get_similar_ok()
        return get_param("similar_ok")
    end
    def set_similar_ok(value)
        set_param("similar_ok", value)
    end

    def get_language()
        return get_param("language")
    end
    def set_language(value)
        set_param("language", value)
    end
end

class TagAnalysis < Search
  def initialize(app_id, context, type='all', results=10, start=1, format=nil, adult_ok=1)
    super Search
    set_app_id(app_id)
  	set_svc_service($SERVICES['tag_analysis'][0])
set_svc_name($SERVICES['tag_analysis'][1])
set_context(context)
set_type(type)
set_results(results)
set_start(start)
set_format(format)
set_adult_ok(adult_ok)
  end
end

class NewsSearch < Search
    def initialize(app_id, query, type='all', results=10, start=1, format=nil, adult_ok=0)
        super Search
    	set_app_id(app_id)
    	set_svc_service($SERVICES['news_search'][0])
	set_svc_name($SERVICES['news_search'][1])
	set_query(query)
	set_type(type)
	set_results(results)
	set_start(start)
	set_format(format)
	set_adult_ok(adult_ok)
    end


    def get_type()
        return get_param("type")
    end
    def set_type(value)
        set_param("type", value)
    end

    def get_sort()
        return get_param("sort")
    end
    def set_sort(value)
        set_param("sort", value)
    end

    def get_language()
        return get_param("language")
    end
    def set_language(value)
        set_param("language", value)
    end
end



class RelatedSuggestion < Search
    def initialize(app_id, query, type='all', results=10, start=1, format=nil, adult_ok=0)
        super Search
    	set_app_id(app_id)
    	set_svc_service($SERVICES['web_related'][0])
	set_svc_name($SERVICES['web_related'][1])
	set_query(query)
	set_type(type)
	set_results(results)
	set_start(start)
	set_format(format)
	set_adult_ok(adult_ok)
    end
end



class SpellingSuggestion < Search
    def initialize(app_id, query, type='all', results=10, start=1, format=nil, adult_ok=0)
        super Search
    	set_app_id(app_id)
    	set_svc_service($SERVICES['spelling'][0])
	set_svc_name($SERVICES['spelling'][1])
	set_query(query)
	set_type(type)
	set_results(results)
	set_start(start)
	set_format(format)
	set_adult_ok(adult_ok)
    end

    def get_query()
        return get_param("query")
    end
    def set_query(value)
        set_param("query",value)
    end
end


##
# MyWeb2
##
class UrlSearch < Search
    def initialize(app_id, tag, yahooid='', sort='date', reverse_sort=0, results=10, start=1)
        super Search
    	set_app_id(app_id)
    	set_svc_service($SERVICES['myweb2_url'][0])
	set_svc_name($SERVICES['myweb2_url'][1])
	set_tag(tag)
	set_yid(yahooid)
	set_sort(sort)
	set_reverse_sort(reverse_sort)
	set_results(results)
	set_start(start)
    end
end



class TagSearch < Search
    def initialize(app_id, url, yahooid='', sort='date', reverse_sort=0, results=10, start=1)
        super Search
    	set_app_id(app_id)
    	set_svc_service($SERVICES['myweb2_tag'][0])
	set_svc_name($SERVICES['myweb2_tag'][1])
	set_url(url)
	set_yid(yahooid)
	set_sort(sort)
	set_reverse_sort(reverse_sort)
	set_results(results)
	set_start(start)
    end
end



class RelatedTags < Search
    def initialize(app_id, tag, yahooid='', sort='date', reverse_sort=0, results=10, start=1)
        super Search
    	set_app_id(app_id)
    	set_svc_service($SERVICES['myweb2_related'][0])
	set_svc_name($SERVICES['myweb2_related'][1])
	set_tag(tag)
	set_yid(yahooid)
	set_sort(sort)
	set_reverse_sort(reverse_sort)
	set_results(results)
	set_start(start)
    end
end