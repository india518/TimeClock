TimeClock::Application.routes.draw do
  get '/summary', :to => 'users#index'
  
  get '/clock_in', :to => 'shifts#new'
  post '/clock_in', :to => 'shifts#create'
  get '/clock_out', :to => 'shifts#edit'
  post '/clock_out', :to => 'shifts#update'
  resources :shifts, :except => [:index, :show]
  #resources :shifts, :except => [:index, :show, :destroy]

  root :to => 'users#index'
end
