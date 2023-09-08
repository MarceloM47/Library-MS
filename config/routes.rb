Rails.application.routes.draw do
  resources :loans do
    member do
      put :return_book
    end
  end  
  root "main#index"
  get 'main/user_index'
  get 'main/admin_index'
  resources :books
  resources :specialities
  devise_for :users, controllers: {
    registrations: 'user/registrations',
    sessions: 'user/sessions'
  }

  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
