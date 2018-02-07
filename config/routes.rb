Rails.application.routes.draw do
  root 'home#index'

  # Registrations controller will overwrite default devise route when user register for an account.
  devise_for :users, controllers: { registrations: "registrations" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
