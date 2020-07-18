Rails.application.routes.draw do
  
  resources :products do 
  		resources :purchases
  end
  resources :books
  devise_for :students, :controllers => { :registrations => "students", :sessions=>'sessions'}
  devise_scope :student do
  	get '/students/index' => "students#index", as: :student_root
    get '/students/show/:id' => "students#show", as: :student_show
    get '/students/search' => "students#search", as: :student_search
    post '/students/find' => "students#find", as: :student_find
  end


root :to => 'public#index'


resources :public
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
