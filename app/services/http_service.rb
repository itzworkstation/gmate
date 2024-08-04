# frozen_string_literal: true

require 'faraday'
class HttpService
  attr_accessor :conn

  def initialize(base_url:)
    @base_url = base_url
    connection
  end

  def connection
    @conn = Faraday.new(url: @base_url)
  end

  def get(_end_point)
    @conn.get('/endpoint')
  end

  def post(end_point, payload:, headers: {})
    headers = { 'Content-Type' => 'application/json' }.merge!(headers)
    @conn.post do |req|
      req.url end_point
      req.headers = headers
      req.body = payload.to_json
    end
  end
end
