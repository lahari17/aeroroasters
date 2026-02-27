Rails.application.routes.draw do
  devise_for :users

  root "home#index"

  # Products catalog
  resources :products, only: [ :index, :show ], param: :slug

  # Cart
  resource :cart, only: [ :show ]
  resources :line_items, only: [ :create, :update, :destroy ]

  # Checkout + Payment success
  resource :checkout, only: [ :new, :create ] do
    get :success, on: :collection
  end

  # Orders
  resources :orders, only: [ :index, :show ]

  # Wishlist
  resource :wishlist, only: [ :show ] do
    post "add/:product_id", to: "wishlists#add", as: :add_product
    delete "remove/:product_id", to: "wishlists#remove", as: :remove_product
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
