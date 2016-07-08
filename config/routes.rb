Rails.application.routes.draw do

  resources :locations do
      post 'get_distance', on: :member
  end
  get 'location/all' => 'locations#index_all'
  get 'about' => 'pages#about'
  get 'contact' => 'pages#contact'
  get 'faq' => 'pages#faq'

  devise_for :users
  resources :users, only: [:show, :index] do
    collection do
      get 'edit_profile' # this will show your view
      patch 'update_profile' # update value in database
    end
  end
  root 'pages#home'
end
