Rails.application.routes.draw do
  root to: redirect('measurements/energy_usage')

  scope 'measurements', controller: 'measurements' do
    get 'energy_usage'
  end

  require 'sidekiq/web'
  # require 'sidetiq/web'
  mount Sidekiq::Web => '/admin/sidekiq'
end
