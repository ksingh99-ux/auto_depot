Rails.application.routes.draw do
  devise_for :customers
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root "products#index"
  resources :products, only: %i[index show]
  resources :categories, only: %i[show]
  delete "recently_viewed", to: "products#clear_recently_viewed", as: :clear_recently_viewed
  get "search", to: "products#search", as: :search

  resource :cart, only: %i[show]
  resources :cart_items, only: %i[create update destroy]

  get "checkout", to: "checkouts#address", as: :checkout
  patch "checkout", to: "checkouts#update_address"
  get "checkout/review", to: "checkouts#review", as: :checkout_review
  post "checkout/place_order", to: "checkouts#create", as: :place_order
  resources :orders, only: %i[show]

  get "about", to: "pages#show", defaults: { slug: "about" }, as: :about
  get "contact", to: "pages#show", defaults: { slug: "contact" }, as: :contact

  get "up" => "rails/health#show", as: :rails_health_check
end
