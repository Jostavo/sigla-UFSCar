require File.expand_path('../spec_helper', __FILE__)

module Danger
  describe Danger::DangerSimpleCovJson do
    it 'should be a plugin' do
      expect(Danger::DangerSimpleCovJson.new(nil)).to be_a Danger::Plugin
    end

    describe 'with Dangerfile' do
      before do
        @dangerfile = testing_dangerfile
        @simplecov = @dangerfile.simplecov
      end

      it 'Shows code coverage report' do
        @simplecov.report('spec/fixtures/coverage.json')

        expect(@dangerfile.status_report[:messages]).to eq(['Code coverage is now at 99.15% (1512/1525 lines)'])
      end

      it 'Shows individual code coverage report' do
        allow(@simplecov.git).to receive(:added_files).and_return([])
        allow(@simplecov.git).to receive(:modified_files)
          .and_return(['another_ruby_file.rb'])

        @simplecov.individual_report('spec/fixtures/coverage.json', nil)
        expect(@dangerfile.status_report[:markdowns][0].message).to eq("### Code Coverage\n\n"\
          "| File                 | Coverage |\n|----------------------|----------|\n"\
          '| another_ruby_file.rb | 20.00%   |')
      end

      it 'Fails if code coverage not found' do
        @simplecov.report('spec/fixtures/missing_file.json')

        expect(@dangerfile.status_report[:errors]).to eq(['Code coverage data not found'])
      end
    end
  end
end
