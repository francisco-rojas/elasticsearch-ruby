# encoding: UTF-8

require 'test_helper'

module LegacyElasticsearch
  module Test
    class APITest < ::Test::Unit::TestCase

      context "The API module" do

        should "access the settings" do
          assert_not_nil LegacyElasticsearch::API.settings
        end

        should "allow to set settings" do
          assert_nothing_raised { LegacyElasticsearch::API.settings[:foo] = 'bar' }
          assert_equal 'bar', LegacyElasticsearch::API.settings[:foo]
        end

        should "have default serializer" do
          assert_equal MultiJson, LegacyElasticsearch::API.serializer
        end

      end

    end
  end
end
