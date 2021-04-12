require 'elasticsearch/extensions/test/cluster'

namespace :elasticsearch do
  desc "Start Elasticsearch cluster for tests"
  task :start do
    LegacyElasticsearch::Extensions::Test::Cluster.start
  end

  desc "Stop Elasticsearch cluster for tests"
  task :stop do
    LegacyElasticsearch::Extensions::Test::Cluster.stop
  end
end
