Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root "products#index"
  resources :products, only: %i[index show]
  resources :categories, only: %i[show]

  get "up" => "rails/health#show", as: :rails_health_check
end
