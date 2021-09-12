# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  devise_for :users, path: "/",
             path_names: { sign_in: :login, sign_out: :logout, registration: :users },
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }

  resources :links
  resources :tags, only: [:index]
end
