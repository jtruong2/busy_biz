Rails.application.routes.draw do
  
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      post "/users", to: "users#create"
      get "/users/me", to: "users#show"
      get "/searches", to: "searches#index"
      get "/businesses", to: "businesses#index"
    end
  end
end
