# frozen_string_literal: true

# Source: https://github.com/sidekiq/sidekiq/blob/a00ac550f8591e2e797017ac3369e11a74991dde/myapp/app/controllers/job_controller.rb
class JobController < ApplicationController
  def index
    @count = rand(100)
    puts "Adding #{@count} jobs"
    @count.times do |x|
      HardJob.perform_async("bubba", 0.01, x)
    end
  end

  def long
    50.times do |x|
      HardJob.perform_async("bob", 15, x)
    end
    render plain: "enqueued"
  end

  def crash
    HardJob.perform_async("crash", 1, Time.now.to_f)
    render plain: "enqueued"
  end
end
