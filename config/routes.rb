Geolocationapp::Application.routes.draw do
  root to: 'locations#index'
  
  resources :locations, only: [:index, :show]
end
