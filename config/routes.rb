Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :addresses
      resources :neighborhoods
      resources :cities
      resources :states
      resources :countries
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
