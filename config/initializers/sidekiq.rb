Sidekiq.configure_client do |config|
  config.redis = {url: "redis://localhost/12", namespace: "enalytics"}
end

Sidekiq.configure_server do |config|
  config.redis = {url: "redis://localhost/12", namespace: "enalytics"}
end