require "elasticsearch/version"

require 'elasticsearch/transport'
require 'elasticsearch/api'

module LegacyElasticsearch
  module Transport
    class Client
      include LegacyElasticsearch::API
    end
  end
end
