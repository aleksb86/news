News::Application.routes.draw do
  resources :roles
  root :to => 'posts#index'
  devise_for :users
  resources :users

  resources :posts do
    resources :attachments, only: [:show, :destroy]
  end

  resources :attachments, except: [:index, :new, :create, :edit, :update]
end
