Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      resource :users, only: [:create]
      get "/users/me", to: "users#show"
    end
  end
end
