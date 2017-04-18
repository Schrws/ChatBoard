Rails.application.routes.draw do
  root 'home#index'

  post '/home/post/add' => 'home#add_post'
  get '/home/post/delete' => 'home#delete_post'
  post '/home/comment/add' => 'home#add_comment'
  get '/home/comment/delete' => 'home#delete_comment'
  get '/home/comments' => 'home#comments'
  get '/home/list' => 'home#list'

  get '/login' => 'session#new'
  post '/login' => 'session#create'
  get '/logout' => 'session#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
