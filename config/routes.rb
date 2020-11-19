Rails.application.routes.draw do
  devise_for :users
  root 'homes#top'
  get 'home/about' => 'homes#about', as: 'about'
  resources :users, only: [:show,:index,:edit,:update]
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  post 'create/:id' => 'relationships#create', as: 'create'
  delete 'destroy/:id' => 'relationships#destroy', as: 'destroy'
  get 'follows/:id' => 'users#follows', as: 'follows'
  get 'followers/:id' => 'users#followers', as: 'followers'
end