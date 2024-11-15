Rails.application.routes.draw do

  # Deviseの設定
  devise_for :admins, controllers: {
    sessions: 'admin/admins/sessions',
    registrations: 'admin/admins/registrations'
  }

  devise_for :users, controllers: {
    sessions: 'public/users/sessions',
    registrations: 'public/users/registrations'
  }

  scope module: :public do
    root "homes#top" # ログイン状態に応じてトップページまたはマイページへリダイレクト
    get "about", to: "homes#about"
    get "mypage", to: "users#show", as: :mypage

    resources :posts, only: [:index, :show, :new, :create]
    resources :users, only: [:show]
  end
  
end
