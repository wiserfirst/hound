require "rails_helper"

describe Buildable do
  class BuildableTestJob < ActiveJob::Base
    include Buildable
  end

  describe "perform" do
    it 'runs build runner' do
      build_runner = double(:build_runner, run: nil)
      payload = double("Payload", github_repo_id: 1)
      allow(Payload).to receive(:new).with(payload_data).and_return(payload)
      allow(BuildRunner).to receive(:new).and_return(build_runner)

      BuildableTestJob.perform_now(payload_data)

      expect(Payload).to have_received(:new).with(payload_data)
      expect(BuildRunner).to have_received(:new).with(payload)
      expect(build_runner).to have_received(:run)
    end

    it "runs repo updater" do
      repo_updater = double(:repo_updater, run: nil)
      payload = double("Payload", github_repo_id: 1)
      allow(Payload).to receive(:new).with(payload_data).and_return(payload)
      allow(UpdateRepoStatus).to receive(:new).and_return(repo_updater)

      BuildableTestJob.perform_now(payload_data)

      expect(Payload).to have_received(:new).with(payload_data)
      expect(UpdateRepoStatus).to have_received(:new).with(payload)
      expect(repo_updater).to have_received(:run)
    end
  end

  def payload_data
    "anything"
  end
end
