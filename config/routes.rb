# frozen_string_literal: true

# Source: https://github.com/sidekiq/sidekiq/blob/a00ac550f8591e2e797017ac3369e11a74991dde/myapp/config/routes.rb 
# turns off browser asset caching so we can test CSS changes quickly
ENV["SIDEKIQ_WEB_TESTING"] = "1"

require "sidekiq/web"
Sidekiq::Web.app_url = "/"

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"
  get "job" => "job#index"
  get "job/long" => "job#long"
  get "job/crash" => "job#crash"
end
