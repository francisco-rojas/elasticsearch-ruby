require 'test_helper'

module LegacyElasticsearch
  module Test
    class BaseAggregationComponentTest < ::Test::Unit::TestCase
      context "BaseAggregationComponent" do

        class DummyAggregationComponent
          include ::LegacyElasticsearch::DSL::Search::BaseAggregationComponent
        end

        class ::LegacyElasticsearch::DSL::Search::Aggregations::Dummy
          include ::LegacyElasticsearch::DSL::Search::BaseAggregationComponent
        end

        subject { DummyAggregationComponent.new }

        should "return an instance of the aggregation by name" do
          assert_instance_of ::LegacyElasticsearch::DSL::Search::Aggregations::Dummy, subject.dummy
        end

        should "raise an exception when unknown aggregation is called" do
          assert_raise(NoMethodError) { subject.foobar }
        end

        should "add a nested aggregation" do
          subject.aggregation :inner do
            dummy field: 'foo'
          end

          assert ! subject.aggregations.empty?, "#{subject.aggregations.inspect} is empty"

          assert_instance_of LegacyElasticsearch::DSL::Search::Aggregation, subject.aggregations[:inner]
          assert_equal( {:dummy=>{:field=>"foo"}}, subject.aggregations[:inner].to_hash )

          assert_equal 'foo', subject.to_hash[:aggregations][:inner][:dummy][:field]
        end
      end
    end
  end
end
