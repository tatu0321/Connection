Rails.application.routes.draw do

  # Deviseの設定
  devise_for :admins, path: 'admin', controllers: {
    sessions: 'admin/admins/sessions'
  }, skip: [:registrations]

  as :admin do
    get 'admin/sign_up', to: redirect('/')  # サインアップページへのアクセスをリダイレクト
  end

  devise_for :users, controllers: {
    sessions: 'public/users/sessions',
    registrations: 'public/users/registrations'
  }

  devise_scope :user do
    post "users/guest_sign_in", to: "public/users/sessions#guest_sign_in"
  end

  # Publicのルート
  scope module: :public do
    root "homes#top" # ログイン状態に応じてトップページまたはマイページへリダイレクト
    get "about", to: "homes#about"
    get 'mypage', to: 'users#show', as: :mypage

    resources :posts do
      resources :post_comments, only: [:create, :destroy, :edit, :update]
    end
    resources :users, only: [:show, :edit, :update, :destroy]
    resources :favorites, only: [:create, :destroy]

  end

  get 'searches', to: 'searches#index'

  # 管理者用のルート
  namespace :admin do
    # 管理者用のDevise設定
    devise_for :admins, skip: [:registrations, :passwords]
    root to: 'users#index' # ログイン後に会員一覧にリダイレクト

    # 管理者の投稿、会員、コメント関連
    resources :posts, only: [:index, :show, :destroy] # 投稿一覧、削除
    resources :users, only: [:index, :show, :destroy] # 会員一覧、詳細、削除
    resources :post_comments, only: [:destroy] # コメント削除
  end
end
