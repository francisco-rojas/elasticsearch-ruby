require 'test_helper'

class LegacyElasticsearch::Transport::Transport::SerializerTest < Test::Unit::TestCase

  context "Serializer" do

    should "use MultiJson by default" do
      ::MultiJson.expects(:load)
      ::MultiJson.expects(:dump)
      LegacyElasticsearch::Transport::Transport::Serializer::MultiJson.new.load('{}')
      LegacyElasticsearch::Transport::Transport::Serializer::MultiJson.new.dump({})
    end

  end

end
