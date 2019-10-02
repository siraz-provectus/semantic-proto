Rails.application.routes.draw do
  root to: 'home#index'

  controller :home do
    post 'search', action: :search
  end
end
