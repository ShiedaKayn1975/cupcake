Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post 'direct_uploads' , to: 'direct_uploads#create'
      get 'hello', to: 'hello#hello'
    end
  end
end
