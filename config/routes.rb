Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      post "/users", to: "users#create"
      get "/users/me", to: "users#show"
      get "/searches", to: "searches#index"
    end
  end
end
