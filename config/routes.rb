Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' },
  path: '',
  path_names: {sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration'}
  devise_scope :user do
    get 'profile_edit', to: 'users/registrations#profile_edit', as: 'profile_edit'
    patch 'profile_update', to: 'users/registrations#profile_update', as: 'profile_update'
  end
  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get 'signup' => 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#delete'
  resources :users, only: [:show, :edit, :update] do
    resources :plans
    post '/create', to: 'plans#create'
  end
  get '/profile_edit', to: 'users#profile_edit'
  patch '/profile_update', to: 'users#profile_update'
end
