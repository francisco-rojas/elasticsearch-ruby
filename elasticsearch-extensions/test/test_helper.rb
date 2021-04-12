RUBY_1_8 = defined?(RUBY_VERSION) && RUBY_VERSION < '1.9'
JRUBY    = defined?(JRUBY_VERSION)

if RUBY_1_8
  puts "Tests for '#{File.expand_path('../..', __FILE__).split('/').last}' not supported on Ruby #{RUBY_VERSION}"
  exit(0)
end

if ENV['COVERAGE'] && ENV['CI'].nil? && !RUBY_1_8
  require 'simplecov'
  SimpleCov.start { add_filter "test_" }
end

if ENV['CI'] && !RUBY_1_8
  require 'simplecov'
  require 'simplecov-rcov'
  SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
  SimpleCov.start { add_filter "/test|test_|ansi" }
end

require 'test/unit'
require 'shoulda-context'
require 'mocha/setup'
require 'ansi/code'
require 'turn' unless ENV["TM_FILEPATH"] || ENV["NOTURN"] || RUBY_1_8
require 'logger'

require 'elasticsearch/extensions'
require 'elasticsearch/extensions/test/startup_shutdown'
require 'elasticsearch/extensions/test/cluster'

module LegacyElasticsearch
  module Test
    class IntegrationTestCase < ::Test::Unit::TestCase
      extend LegacyElasticsearch::Extensions::Test::StartupShutdown

      startup do
        LegacyElasticsearch::Extensions::Test::Cluster.start(nodes: 2) if ENV['SERVER'] and not LegacyElasticsearch::Extensions::Test::Cluster.running?
      end

      shutdown do
        LegacyElasticsearch::Extensions::Test::Cluster.stop if ENV['SERVER'] and LegacyElasticsearch::Extensions::Test::Cluster.running?
      end
    end
  end
end
