Events::Application.routes.draw do

  root "events#index"

  get 'signup' => 'users#new'
  resources :users

  resources :events do
    resources :registrations
  end
end
