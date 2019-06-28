Rails.application.routes.draw do
  root 'nerds#index'

  get 'nerds/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
