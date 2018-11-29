Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :welcome, :only => [:index]
  root "welcome#index"
  resources :users, :only => [:show, :index, :edit, :update]
  resources :messages, :only => [:create]
  resources :rooms, :only => [:create, :show, :index, :edit, :update, :destroy]
end
