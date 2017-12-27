Rails.application.routes.draw do
  devise_for :admins
  get 'locations/index'
  get 'locations/new', to: 'locations#new'
  get 'locations/get_locations', to: 'locations#get_locations'
  get 'locations/get_beer', to: 'locations#get_all_beer'
  get 'locations/get_wine', to: 'locations#get_all_wine'
  get 'locations/get_liquor', to: 'locations#get_all_liquor'
  get 'locations/get_all_locations', to: 'locations#get_all_locations'
  root to: 'locations#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :locations do
    collection do
      post :import
    end
  end
end
