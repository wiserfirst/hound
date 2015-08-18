module Buildable
  def perform(payload_data)
    payload = Payload.new(payload_data)

    repo_updater = RepoUpdater.new(payload)
    repo_updater.run
    build_runner = BuildRunner.new(payload)
    build_runner.run
  end
end
