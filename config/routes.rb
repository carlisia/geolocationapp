Geolocationapp::Application.routes.draw do
  
  
  #resources :locations, only: [:index, :show]
  
  resources :locations do
      collection { post :import }
  end
  
  root to: 'locations#index'
end
