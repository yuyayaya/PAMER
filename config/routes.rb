Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations', sessions: 'users/sessions' },
  path: '',
  path_names: {sign_in: 'login', sign_out: 'logout', edit: 'setting', sign_up: 'registration'}
  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get 'signup' => 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#delete'
  resources :users, only: [:show, :index] do
    resources :plans
    post '/create', to: 'plans#create'
  end
  get '/profile_edit', to: 'users#profile_edit'
  post '/profile_update', to: 'users#profile_update'
  get '/plans', to: 'plans#plan_index'
  resources :rooms, only: [:show, :index, :create]
end
