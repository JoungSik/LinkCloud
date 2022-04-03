# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  root "home#index"

  devise_for :users, path: "",
             path_names: { sign_in: :login, sign_out: :logout, registration: :users },
             controllers: {
               sessions: "users/sessions",
               registrations: "users/registrations",
               passwords: "users/passwords",
             }

  scope module: :v1 do
    resources :links
  end
end
