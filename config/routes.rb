Rails.application.routes.draw do
  # 未ログイン時のトップページ
  unauthenticated :user do
    root "homes#top", as: :unauthenticated_root
    get "about" => "homes#about"
  end

  # ログイン後のユーザーのルート（マイページ）
  authenticated :user do
    root "public/users#show", as: :authenticated_root
  end

  # 公開（ユーザー側）のルート設定
  scope module: :public do
    resources :posts, only: [:index, :show, :create, :new]
    get "mypage", to: "users#show", as: :mypage
  end

  # Deviseの設定
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    registrations: 'admins/registrations'
  }

  devise_for :users, controllers: {
    sessions: 'public/users/sessions',
    registrations: 'public/users/registrations'
  }
end
