Geolocationapp::Application.routes.draw do

  #resources :locations, only: [:index, :show]
  root to: 'home#index'
  
  resources :home, only: [:index]

  resources :locations do
    get "/locations" => "location#index"
    collection    { post :import }
  end

  #get "/locations" => "location#index", :as => :locationss
end
