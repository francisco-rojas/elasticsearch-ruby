require "elasticsearch/watcher/version"

Dir[ File.expand_path('../watcher/api/actions/**/*.rb', __FILE__) ].each   { |f| require f }

module LegacyElasticsearch
  module Watcher
    def self.included(base)
      base.__send__ :include, LegacyElasticsearch::API::Watcher
    end
  end
end

module LegacyElasticsearch
  module API
    module Watcher
      module Actions; end

        # Client for the "watcher" namespace (includes the {Watcher::Actions} methods)
        #
        class WatcherClient
          include LegacyElasticsearch::API::Common::Client,
                  LegacyElasticsearch::API::Common::Client::Base,
                  LegacyElasticsearch::API::Watcher::Actions
        end

        # Proxy method for {WatcherClient}, available in the receiving object
        #
        def watcher
          @watcher ||= WatcherClient.new(self)
        end
    end
  end
end

LegacyElasticsearch::API.__send__ :include, LegacyElasticsearch::API::Watcher

LegacyElasticsearch::Transport::Client.__send__ :include, LegacyElasticsearch::API::Watcher if defined?(LegacyElasticsearch::Transport::Client)
