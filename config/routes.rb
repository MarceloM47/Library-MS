Rails.application.routes.draw do
  root "books#index"

  resources :loans do
    member do
      put :return_book
    end
  end

  resources :books do
    get 'search', on: :collection # books/search -> books#search
  end

  resources :specialities
  
  resources :admin_users

  devise_for :users, controllers: {
    registrations: 'user/registrations',
    sessions: 'user/sessions'
  }

  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end
end
