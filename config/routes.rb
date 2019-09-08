Rails.application.routes.draw do
  root 'index#index'
  namespace :staffs do
    get '/', to: 'index#index', as: :root
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
