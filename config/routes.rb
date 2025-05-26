# config/routes.rb
Rails.application.routes.draw do
  devise_for :admin_users, path: "admin", controllers: {
    sessions: "admin/sessions"
  }

  devise_for :users, path: "", controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_scope :user do
    post "users/guest_login", to: "public/sessions#guest_login"
  end

  scope module: :public do
    root to: "homes#top"

    resources :reviews do
      collection do
        get :search
        get :tag_search
      end
      resources :comments, only: [:create, :destroy]
    end

    resources :users, only: [:index, :show, :edit, :update] do
      member do
        get :confirm
        patch :withdraw
      end
      collection do
        get :search
      end
    end
  end

  namespace :admin do
    root to: "homes#top"
    resources :users, only: [:index, :update]
    resources :comments, only: [:index, :destroy]
    resources :reviews, only: [:index, :destroy]
  end
end
