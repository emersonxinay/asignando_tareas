Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end
  resources :tasks
  resources :categories
  root 'tasks#index'
  # para verificar rutas desde el navegador 
  # localhost:3000/rails/info/routes
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
