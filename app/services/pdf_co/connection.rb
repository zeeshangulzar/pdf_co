require 'faraday'
require 'json'

module PdfCo
  class Connection

    def self.api
      Faraday.new(url: ENV['PDF_CO_URL']) do |faraday|
        faraday.response :logger
        faraday.adapter Faraday.default_adapter
        faraday.headers['Content-Type'] = 'application/json'
        faraday.headers['X-API-KEY'] = ENV['PDF_CO_KEY']
      end
    end
  end
end
