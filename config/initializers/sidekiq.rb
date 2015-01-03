require 'sidekiq'
require 'sidekiq/web'

Sidekiq.configure_client do |config|
  config.redis = {url: "redis://localhost/12", namespace: "enalytics"}
end

Sidekiq.configure_server do |config|
  config.redis = {url: "redis://localhost/12", namespace: "enalytics"}
end

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  user == Rails.application.secrets.sidekiq_username &&
  password == Rails.application.secrets.sidekiq_password
end