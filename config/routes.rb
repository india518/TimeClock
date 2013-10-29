TimeClock::Application.routes.draw do
  get '/summary', :to => 'shifts#index'
  post '/summary', :to => 'shifts#index'
  
  get '/clock', :to => 'shifts#show'
  post '/clock', :to => 'shifts#show'
  post '/clock_in', :to => 'shifts#create'
  post '/clock_out', :to => 'shifts#update'
  #resources :shifts, :only => [:destroy]	#needed?
  
  root :to => 'shifts#index'
end
