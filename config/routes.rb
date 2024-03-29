LyxhLiyihuaFkezaMweeFinal::Application.routes.draw do
  resources :trip_invitations

  get "friendships/create"
  get "friendship/create"
  # The priority is based upon order of creation: first created -> highest priority.
# See how all your routes lay out with "rake routes".
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]

# You can have the root of your site routed with "root"
 root 'welcome#home'
 resources :users
 resources :trips
 resources :freeranges
 resources :activities
 resources :invites
 resources :tripinvitations
 resources :friendships
 
 match 'activities/like/:id' => 'activities#like', :as => :like_activity, via: [:get, :post]
 match 'activities/unlike/:id' => 'activities#unlike', :as => :unlike_activity, via: [:get, :post]
 
 match 'users/show/:id' => 'users#show', :as => :user_show, via: [:get, :post]
 match 'users/show_friend/:id' => 'users#show_friend', :as => :user_show_friend, via: [:get, :post]
 match 'users/edit_destination/:id' => 'users#edit_destination', :as => :user_edit_destination, via: [:get, :post]
 match 'users/edit_budget/:id' => 'users#edit_budget', :as => :user_edit_budget, via: [:get, :post]

  match 'trips/:id/trip_invitations/new' => 'trip_invitations#new', :as => :trip_add_invitations_new, via: [:get, :patch, :post]
  match 'trips/:id/trip_invitations/create' => 'trip_invitations#create', :as => :trip_add_invitations_create, via: [:get, :patch, :post]
  
  match 'trips/:id/activities/new' => 'activities#new', :as => :trip_activities_new,  via: [:get, :patch, :post]
  match 'trips/:id/activities/create' => 'activities#create', :as => :trip_activities_create,  via: [:get, :patch, :post]
	
  get ':controller(/:action(/:id))(.:format)'
  post ':controller(/:action(/:id))(.:format)'
  

  match '/friendships/accept/:id' => 'friendships#accept', :as => :accept_invitation, via: [:get,:post]
  
  delete '/friendships/:id/decline', to: 'friendships#decline', as: 'decline_invitation'
  
    
    
# Example of regular route:
#   get 'products/:id' => 'catalog#view'

# Example of named route that can be invoked with purchase_url(id: product.id)
#   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

# Example resource route (maps HTTP verbs to controller actions automatically):
#   resources :products

# Example resource route with options:
#   resources :products do
#     member do
#       get 'short'
#       post 'toggle'
#     end
#
#     collection do
#       get 'sold'
#     end
#   end

# Example resource route with sub-resources:
#   resources :products do
#     resources :comments, :sales
#     resource :seller
#   end

# Example resource route with more complex sub-resources:
#   resources :products do
#     resources :comments
#     resources :sales do
#       get 'recent', on: :collection
#     end
#   end

# Example resource route with concerns:
#   concern :toggleable do
#     post 'toggle'
#   end
#   resources :posts, concerns: :toggleable
#   resources :photos, concerns: :toggleable

# Example resource route within a namespace:
#   namespace :admin do
#     # Directs /admin/products/* to Admin::ProductsController
#     # (app/controllers/admin/products_controller.rb)
#     resources :products
#   end
end
