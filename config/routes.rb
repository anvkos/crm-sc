Rails.application.routes.draw do
  root 'index#index'
  namespace :staffs do
    devise_for :staffs, path: '', controllers: {
        sessions: 'staffs/sessions'
    }
    get '/', to: 'index#index', as: :root
    get '/user', to: 'index#user', as: :user
    resources :clients do
      collection do
        post 'verify_uniqueness'
      end
    end
  end
  namespace :clients do
    devise_for :clients, path: '', controllers: {
        sessions: 'clients/sessions'
    }
    get '/', to: 'index#index', as: :root
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
