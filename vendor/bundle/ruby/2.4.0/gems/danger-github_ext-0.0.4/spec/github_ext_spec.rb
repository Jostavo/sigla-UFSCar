require File.expand_path('../spec_helper', __FILE__)

module Danger
  describe Danger::DangerGithubExt do
    it 'should be a plugin' do
      expect(Danger::DangerGithubExt.new(testing_dangerfile)).to be_a Danger::Plugin
    end

    before :all, 'stub setting' do
      RSpec.configure do |config|
        config.mock_with :rspec do |mocks|
          mocks.allow_message_expectations_on_nil = true
        end
      end
    end

    #
    # You should test your custom attributes and methods here
    #
    describe 'with Dangerfile' do
      before do
        @dangerfile = testing_dangerfile
        @my_plugin = @dangerfile.github
      end

      # Some examples for writing tests
      # You should replace these with your own.

      it 'should be true when mergeable' do
        allow(@my_plugin.pr_json).to receive(:attrs).and_return({
                                                                    :mergeable => true,
                                                                    :mergeable_state => 'clean'
                                                                })
        expect(@my_plugin.mergeable?).to be true
      end

      it 'should be false when dont mergeable' do
        allow(@my_plugin.pr_json).to receive(:attrs).and_return({
                                                                    :mergeable => false,
                                                                    :mergeable_state => 'clean'
                                                                })
        expect(@my_plugin.mergeable?).to be false
      end

      it 'should be false when mergeable state is dirty' do
        allow(@my_plugin.pr_json).to receive(:attrs).and_return({
                                                                    :mergeable => true,
                                                                    :mergeable_state => 'dirty'
                                                                })
        expect(@my_plugin.mergeable?).to be false
      end
    end
  end
end
