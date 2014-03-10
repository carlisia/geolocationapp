require 'api_contraints'

Geolocationapp::Application.routes.draw do

  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :relative_locations, only: [:index]
    end
  end

  resources :locations do
    get "/locations" => "locations#index"
    post :import, :on => :collection
  end
  
  root to: 'home#index'

end
