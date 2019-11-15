Rails.application.routes.draw do
  namespace :admin do
    devise_for :admin_users, skip: [:registrations, :passwords], path: '', path_names: { sign_in: 'login', sign_out: 'logout'}
    get '/', to: 'home#index'
    resources :profiles, only: [:index, :show]
    resources :quizes do
      resources :questions do
        resources :answer
      end
    end
  end

  root to: 'home#index'

  controller :home do
    post 'words', action: :search
  end

  resources :callbacks, only: :create

  get "*path" => redirect("/")
end
