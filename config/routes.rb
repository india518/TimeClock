TimeClock::Application.routes.draw do
  get '/summary', :to => 'shifts#index'
  post '/summary', :to => 'shifts#index'
  
  get '/clock', :to => 'shifts#show'
  post '/clock', :to => 'shifts#show'
  post '/clock_in', :to => 'shifts#create'
  post '/clock_out', :to => 'shifts#update'
  #resources :shifts, :only => [:destroy]	#needed?
  
  root :to => 'shifts#index'
  match '/shift/find_shifts' => 'shifts#find_shifts', :as => 'shift_search', :via => [:post]
  match '/shift/show_clock' => 'shifts#show_clock', :as => 'shift_clock', :via => [:post]
end
