Rails.application.routes.draw do
  namespace :admin do
    get 'dashboards/index'
  end
  # Deviseの設定
  devise_for :admins, path: 'admin', controllers: {
    sessions: 'admin/admins/sessions'
  }

  devise_for :users, controllers: {
    sessions: 'public/users/sessions',
    registrations: 'public/users/registrations'
  }

  devise_scope :user do
    post "users/guest_sign_in", to: "public/users/sessions#guest_sign_in"
  end

  scope module: :public do
    root "homes#top" # ログイン状態に応じてトップページまたはマイページへリダイレクト
    get "about", to: "homes#about"
    get 'mypage', to: 'users#show', as: :mypage

    resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    resources :users, only: [:show, :edit, :update, :destroy]
  end

  namespace :admin do
    root "dashboards#index"
  end
end
