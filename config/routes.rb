Rails.application.routes.draw do

  scope module: :public do
    resources :posts, only: [:index]
    root "homes#top"
    get "about" => "homes#about"
  end
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    registrations: 'admins/registrations'
  }

  devise_for :users, controllers: {
    sessions: 'public/users/sessions',
    registrations: 'public/users/registrations'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
