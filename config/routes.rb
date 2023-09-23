Rails.application.routes.draw do
  resources :loans do
    member do
      put :return_book
    end
  end  
  root "books#index"
  resources :books do
    get 'search', on: :collection # books/search -> books#search
  end
  resources :specialities
  devise_for :users, controllers: {
    registrations: 'user/registrations',
    sessions: 'user/sessions'
  }

  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end
end
