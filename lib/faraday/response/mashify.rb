require 'faraday'

module Faraday
  class Response::Mashify < Response::Middleware
    dependency 'rash'

    class << self
      attr_accessor :mash_class
    end

    self.mash_class = ::Hashie::Rash

    def parse(body)
      case body
      when Hash
        self.class.mash_class.new(body)
      when Array
        body.map { |item| item.is_a?(Hash) ? self.class.mash_class.new(item) : item }
      else
        body
      end
    end
  end
end
