Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root "products#index"
  resources :products, only: %i[index show]
  resources :categories, only: %i[show]
  delete "recently_viewed", to: "products#clear_recently_viewed", as: :clear_recently_viewed

  get "up" => "rails/health#show", as: :rails_health_check
end
