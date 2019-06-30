Rails.application.routes.draw do
  root 'nerds#index'

  resources :nerds, only: [:index, :show] do
    get 'search/(:user_name)', action: :search, as: :search, on: :collection
  end
end
