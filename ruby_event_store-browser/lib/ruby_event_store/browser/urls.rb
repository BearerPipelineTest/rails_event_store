module RubyEventStore
  module Browser
    class Urls
      def self.from_configuration(host, root_path, api_url = nil)
        new(host, root_path, api_url)
      end

      def self.initial
        new(nil, nil, nil)
      end

      def with_request(request)
        Urls.new(host || request.base_url, root_path || request.script_name, api_url)
      end

      attr_reader :app_url, :api_url, :host, :root_path

      def initialize(host, root_path, api_url)
        @host = host
        @root_path = root_path
        @app_url = [host, root_path].compact.reduce(:+)
        @api_url = api_url || ("#{app_url}/api" if app_url)
      end

      def events_url
        "#{api_url}/events"
      end

      def streams_url
        "#{api_url}/streams"
      end

      def paginated_events_from_stream_url(id:, position: nil, direction: nil, count: nil)
        stream_name = Rack::Utils.escape(id)
        query_string =
          URI.encode_www_form(
            { "page[position]" => position, "page[direction]" => direction, "page[count]" => count }.compact
          )

        if query_string.empty?
          "#{api_url}/streams/#{stream_name}/relationships/events"
        else
          "#{api_url}/streams/#{stream_name}/relationships/events?#{query_string}"
        end
      end

      def browser_js_url
        "#{app_url}/ruby_event_store_browser.js"
      end

      def browser_css_url
        "#{app_url}/ruby_event_store_browser.css"
      end

      def bootstrap_js_url
        "#{app_url}/bootstrap.js"
      end

      def ==(o)
        self.class.eql?(o.class) && app_url.eql?(o.app_url) && api_url.eql?(o.api_url)
      end
    end
  end
end
