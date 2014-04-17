Events::Application.routes.draw do

  root "events#index"

  post 'sessions' => 'sessions#create'
  delete 'signout' => 'sessions#destroy'
  get 'signin' => 'sessions#new'
  get 'signup' => 'users#new'
  resources :users

  resources :events do
    resources :registrations
    resources :likes
  end
end
