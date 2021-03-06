Rails.application.routes.draw do
  
  mount Rswag::Api::Engine => '/api-docs'
  mount Rswag::Ui::Engine => '/api-docs'

  get "/", to: redirect('/api-docs')
  
  namespace :api do
    namespace :v1 do
      post "/users",               to: "users#create"
      post "/users/refresh-token", to: "users#refresh_token"
      get "/searches",             to: "searches#index"
      get "/businesses",           to: "businesses#index"
    end
  end
end
