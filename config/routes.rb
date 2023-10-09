Rails.application.routes.draw do
  root "books#index"

  resources :loans do

    member do
      put :return_book
      get :user_loans
    end

    get 'search', on: :collection
  end

  resources :books do
    get 'search', on: :collection
  end

  resources :specialities
  
  resources :admin_users do
    get 'search', on: :collection
  end

  devise_for :users, controllers: {
    registrations: 'user/registrations',
    sessions: 'user/sessions'
  }

  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end
end
