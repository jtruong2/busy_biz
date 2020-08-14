Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      post "/users",               to: "users#create"
      post "/users/refresh-token", to: "users#refresh_token"
      get "/searches",             to: "searches#index"
      get "/businesses",           to: "businesses#index"
    end
  end
end
