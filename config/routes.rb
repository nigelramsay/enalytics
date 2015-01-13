Rails.application.routes.draw do
  root to: redirect('measurements/energy_usage')

  scope 'measurements', controller: 'measurements' do
    get 'energy_usage'
    get 'putnam_current_temperatures'
    get 'putnam_set_temperatures'
    get 'karori_temperatures'
  end

  require 'sidekiq/web'
  require 'sidetiq/web'
  mount Sidekiq::Web => '/admin/sidekiq'
end
