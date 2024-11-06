Rails.application.routes.draw do
  scope module: :public do
    root "homes#top"
    get "about" => "homes#about"
  end
  devise_for :admins
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
