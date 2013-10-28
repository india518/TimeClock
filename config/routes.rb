TimeClock::Application.routes.draw do
  root :to => 'users#index'
  get '/summary', :as => 'users#index'
  
  get '/clock_in', :as => 'shifts#new'
  post '/clock_in', :as => 'shifts#create'
  get '/clock_out', :as => 'shifts#edit'
  post '/clock_out', :as => 'shifts#update'
  resources :shifts => :except [index, show]
  #resources :shifts => :except [index, show, destroy]
end
