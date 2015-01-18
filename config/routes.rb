Rails.application.routes.draw do
  root to: redirect('portal')

  scope 'measurements', controller: 'api/measurements' do
    get 'energy_usage'
    get 'putnam_current_temperatures'
    get 'putnam_set_temperatures'
    get 'putnam_heating_status'
    get 'karori_temperatures'
    get 'karori_wind'
  end

  scope 'portal', controller: 'portal' do 
    get '', action: 'index'
    get 'links', action: 'links'
  end

  require 'sidekiq/web'
  require 'sidetiq/web'
  mount Sidekiq::Web => '/admin/sidekiq'
end
