require 'test_helper'

module LegacyElasticsearch
  module Test
    class WrapperGemTest < ::Test::Unit::TestCase

      context "Wrapper gem" do

        should "require all neccessary subgems" do
          assert defined? LegacyElasticsearch::Client
          assert defined? LegacyElasticsearch::API
        end

        should "mix the API into the client" do
          client = LegacyElasticsearch::Client.new

          assert_respond_to client, :search
          assert_respond_to client, :cluster
          assert_respond_to client, :indices
        end

      end

    end
  end
end
