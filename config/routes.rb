Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  # User routes
  get '/users', to: 'users#index' # displays a list of all users
  post '/users', to: 'users#create' # creates a new user
  patch '/users/:id', to: 'users#update' # updates a user
  delete '/users/:id', to: 'users#destroy' # deletes a user
  get '/users/verify', to: 'users#current_user_id'
  get '/users/:id', to: 'users#get_username'

  # Post routes
  get '/posts', to: 'posts#index' # displays a list of all posts
  post '/posts', to: 'posts#create' # creates a new post
  # post '/post/:id', to: 'post#find' #find specific post
  get '/posts/:id', to: 'posts#show' # displays a specific post
  patch '/posts/:id', to: 'posts#update' # updates a post
  delete '/posts/:id', to: 'posts#destroy' # deletes a post
  get 'posts/category/:id', to: 'posts#find_cat'
  get 'posts/user/:id', to: 'posts#find_user_post'
  get 'posts/query/:content', to: 'posts#search_posts'

  # Comment routes
  get '/comments', to: 'comments#index' # displays a list of all comments
  post '/comments', to: 'comments#create' # creates a new comment
  get '/comments/:id', to: 'comments#show' #find specific commet
  patch '/comments/:id', to: 'comments#update' # updates a comment
  delete '/comments/:id', to: 'comments#destroy' # deletes a comment
  get '/comments/posts/:id', to: 'comments#find' #finds ALL comments of a post


  #Sign in Route
  post '/signin', to: 'sessions#create' #creates a jwt for user session

end
