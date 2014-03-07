Geolocationapp::Application.routes.draw do

  root to: 'home#index'

  resources :home, only: [:index]

  resources :locations do
    get "/locations" => "location#index"
    collection    { post :import }
  end

end
