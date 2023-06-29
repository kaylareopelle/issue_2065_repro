# frozen_string_literal: true

# Source: https://github.com/sidekiq/sidekiq/blob/a00ac550f8591e2e797017ac3369e11a74991dde/myapp/app/sidekiq/hard_job.rb
class HardJob
  include Sidekiq::Job
  sidekiq_options backtrace: 5

  def perform(name, count, _salt)
    raise name if name == "crash"
    logger.info Time.now
    sleep count
  end
end
