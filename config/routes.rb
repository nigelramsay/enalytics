Rails.application.routes.draw do
  get 'measurements/:action', controller: 'measurements'

end
