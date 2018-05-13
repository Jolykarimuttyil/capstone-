Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  namespace :v1 do
    get 'recipes' => 'recipes#index'
    post "/recipes" => "recipes#create"
    get "/recipes/:id" => "recipes#show"
    patch "/recipes/:id" => "recipes#update"
    delete "/recipes/:id" => "recipes#destroy"
    get '/recipes_search' => "recipes#api_search"
   

    get 'directions' => 'directions#index'
    post "/directions" => "directions#create"
    get "/directions/:id" => "directions#show"
    patch "/directions/:id" => "directions#update"
    delete "/directions/:id" => "directions#destroy"

    post "/ingredients" => "ingredients#create"
    get "/ingredients/:id" => "ingredients#show"
    patch "/ingredients/:id" => "ingredients#update"
    delete "/ingredients/:id" => "ingredients#destroy"

    post "/fridge_items" => "fridge_items#create"
    get "/fridge_items/:id" => "fridge_items#show"
    patch "/fridge_items/:id" => "fridge_items#update"
    delete "/fridge_items/:id" => "fridge_items#destroy"

    post "/users" => "users#create"
  end
end 
