TimeClock::Application.routes.draw do
  get '/summary', :to => 'shifts#index'
  post '/summary', :to => 'shifts#index'
  
  get '/clock_in', :to => 'shifts#new'
  post '/clock_in', :to => 'shifts#create'
  get '/clock_out', :to => 'shifts#edit'
  post '/clock_out', :to => 'shifts#update'
  #resources :shifts, :only => [:destroy]	#needed?
  
  root :to => 'shifts#index'
end
