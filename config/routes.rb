Rails.application.routes.draw do
  
  resources :events do
  	    get 'search', on: :collection
  	    post 'events_search', on: :collection
  	    post 'attend_event', as: :attend_event
  	    post 'unattend_event', as: :unattend_event
  end

  resources :products do 
  		resources :purchases
  end
  resources :books
  devise_for :students, :controllers => { :registrations => "students", :sessions=>'sessions'}
  devise_scope :student do
  	get '/students/index' => "students#index", as: :student_root
    get '/students/show/:id' => "students#show", as: :student_show
    get '/students/search' => "students#search", as: :search
    post '/students/student_search' => "students#student_search", as: :student_search
    post '/students/roomate_search' => "students#roomate_search", as: :roomate_search
  end


root :to => 'public#index'


resources :public
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
