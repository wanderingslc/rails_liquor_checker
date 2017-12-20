Rails.application.routes.draw do
  devise_for :admins
  get 'locations/index'
  get 'locations/new', to: 'locations#new'
  get 'locations/get_locations', to: 'locations#get_locations'
  root to: 'locations#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :locations do
    collection do
      post :import
    end
  end
end
