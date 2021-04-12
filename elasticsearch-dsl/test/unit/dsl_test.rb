require 'test_helper'

module LegacyElasticsearch
  module Test
    class DSLTest < ::Test::Unit::TestCase
      context "The DSL" do
        class DummyDSLReceiver
          include LegacyElasticsearch::DSL
        end

        should "include the module in receiver" do
          assert_contains DummyDSLReceiver.included_modules, LegacyElasticsearch::DSL
          assert_contains DummyDSLReceiver.included_modules, LegacyElasticsearch::DSL::Search
        end
      end
    end
  end
end
