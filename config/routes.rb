Rails.application.routes.draw do
  root to: 'home#index'

  controller :home do
    post 'words', action: :search
  end
end
