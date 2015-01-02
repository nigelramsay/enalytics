Rails.application.routes.draw do
  root to: redirect('measurements/energy_usage')

  scope 'measurements', controller: 'measurements' do
    get 'energy_usage'
  end
end
