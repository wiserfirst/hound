module Buildable
  def perform(payload_data)
    payload = Payload.new(payload_data)

    RepoUpdater.new(payload).run

    build_runner = BuildRunner.new(payload)
    build_runner.run
  end
end
