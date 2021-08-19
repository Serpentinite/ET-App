Rails.application.routes.draw do
  root 'homes#index'

  # resources :users, only: %i[show]
  get 'users/mypage/:id' => 'users#show', as: :user
  get 'mypage' => 'users#mypage'

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'   
  } 

  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy" 
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :boards
  # resources :comments, only: %i[create destroy]
  resources :comments do
    resource :favorites, only: %i[create destroy]
  end

  resources :records, only: %i[index create destroy]
end