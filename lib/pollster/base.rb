require 'json'
require 'uri'
require 'net/http'
require 'date'
require 'time'
require 'zlib'

module Pollster

  class Base
    API_SERVER = 'elections.huffingtonpost.com'
    API_BASE = '/pollster/api'

    class << self

      private

        def encode_params(params)
          params.map { |k, v| "#{k}=#{v}" }.join('&')
        end

        def build_request_url(path, params={})
          URI("http://#{API_SERVER}#{API_BASE}/#{path}#{params.size > 0 ? "?#{encode_params(params)}" : ''}")
        end

        def invoke(path, params={})
          uri = build_request_url(path, params)
          request = Net::HTTP::Get.new(uri.request_uri)
          request['Accept-Encoding'] = 'gzip,deflate'
          response = Net::HTTP.start(uri.host, uri.port) { |http| http.request(request) }
          body = response.header['Content-Encoding'].eql?('gzip') ?
                 Zlib::GzipReader.new(StringIO.new(response.body)).read() :
                 response.body
          raise Exception, JSON.parse(body)["errors"].join(', ') if response.code.eql?('400')
          JSON.parse(body)
        end

    end
  end

end
