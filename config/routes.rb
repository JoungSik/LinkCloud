Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'

  get "*page", to: "home#index", constraints: -> (req) do
    !req.xhr? && req.format.html?
  end

  namespace :v1 do
    devise_for :users, path: "",
               path_names: { sign_in: :login, sign_out: :logout, registration: :users },
               controllers: {
                 sessions: 'v1/users/sessions',
                 registrations: 'v1/users/registrations'
               }

    resources :links
  end
end
