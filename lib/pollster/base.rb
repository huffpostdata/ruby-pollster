require 'json'
require 'uri'
require 'net/http'
require 'date'
require 'time'

module Pollster

  class Base
    API_SERVER = 'elections.huffingtonpost.com'
    API_BASE = '/pollster/api'

    class << self

      private

        def build_request_url(path, params={})
          uri = URI("http://#{API_SERVER}#{API_BASE}/#{path}")
          uri.query = URI.encode_www_form(params)
          uri
        end

        def invoke(path, params={})
          uri = build_request_url(path, params)
          response = Net::HTTP.get_response(uri)
          body = response.header['Content-Encoding'].eql?('gzip') ?
                 Zlib::GzipReader.new(StringIO.new(response.body)).read() :
                 response.body
          raise Exception, JSON.parse(body)["errors"].join(', ') if response.code.eql?('400')
          JSON.parse(body)
        end

    end
  end

end
