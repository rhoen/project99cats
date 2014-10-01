Rails.application.routes.draw do
  resources :cats do
    resources :cat_rental_requests, only: :new, as: "rental_requests"
  end

  resources :cat_rental_requests, only: :create do
    member do
      post "approve"
      post "deny"
    end
  end

  resources :users, only: [:new, :create] do
    resources :sessions, only: :index
  end

  resource :session

  root to: "cats#index"
end
