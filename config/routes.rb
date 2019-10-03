Rails.application.routes.draw do
  root 'index#index'

  devise_for :staffs, controllers: { sessions: 'staffs/sessions' }
  devise_for :clients, controllers: { sessions: 'clients/sessions' }

  namespace :staffs do
    get '/', to: 'index#index', as: :root
    scope constraints: ->(req) { req.format == :json } do
      get '/user', to: 'index#user', as: :user
      resources :clients do
        collection do
          post 'verify_uniqueness'
        end
      end
      resources :organizations
      resources :staffs, only: %i[index create show update]
      resources :equipment, only: %i[index create]
    end
    get '/*slug', to: 'index#index'
  end

  namespace :clients do
    get '/', to: 'index#index', as: :root
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
