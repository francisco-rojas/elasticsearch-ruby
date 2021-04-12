require 'test_helper'

module LegacyElasticsearch
  module Test
    class WatcherGetWatchTest < ::Test::Unit::TestCase

      context "Watcher: Get watch" do
        subject { FakeClient.new }

        should "perform correct request" do
          subject.expects(:perform_request).with do |method, url, params, body|
            assert_equal 'GET', method
            assert_equal "_watcher/watch/foo", url
            assert_equal Hash.new, params
            assert_nil   body
            true
          end.returns(FakeResponse.new)

          subject.watcher.get_watch id: 'foo'
        end

      end

    end
  end
end
