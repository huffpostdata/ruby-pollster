require 'json'
require 'open-uri'
require 'uri'

module Pollster

  class Base
    API_SERVER = 'elections.huffingtonpost.com'
    API_BASE = '/pollster/api'

    class << self

      private

        def build_request_url(path, params={})
          URI::HTTP.build :host => API_SERVER, :path => "#{API_BASE}/#{path}.json", :query => params.map { |k, v| "#{k}=#{v}" }.join('&')
        end

        def invoke(path, params={})
          uri = build_request_url(path, params)
          response = uri.read
          JSON.parse(response)
        end

    end
  end

end
