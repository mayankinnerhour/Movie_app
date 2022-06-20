Rails.application.routes.draw do
  root "movies#index"
  
  devise_for :users
  
  resources :movies do 
    get :favorite, on: :member
    get :search, on: :collection
    # collection do
    #   get "search"
    # end
    resources :reviews, except: [ :show, :index ]
  end

 
end
