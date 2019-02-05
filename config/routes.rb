Descubriendony::Application.routes.draw do
  
  
  resources :sitemap, :only =>:index
  get 'sitemap.xml',:controller =>"sitemap",:action =>"xml"

  #get "sitemap/index"
  resources :transportations

  resources :subscribers

 resources :pages

  mount Ckeditor::Engine => '/ckeditor'
  match "/activities/:category_id/:id" => "activities#show", via: :get
  match "/activities/search", via: :get
  resources :activities

  match "/admin/activities/:id/edit" => "activities#edit", via: :get
  match "/admin/activities/" => "admin#activities", via: :get
  match "/admin/categories/" => "admin#categories", via: :get
  match "/admin/categories/new" => "categories#new", via: :get
  match "/admin/categories/:id/edit" => "categories#edit", via: :get
  resources :categories


  
  match "/admin/pages/" => "admin#pages", via: :get
  match "/admin/pages/new" => "pages#new", via: :get
  match "/admin/pages/:id/edit" => "pages#edit", via: :get
  
  match "/admin/transportations/" => "admin#transportations", via: :get
  match "/admin/transportations/new" => "transportations#new", via: :get
  match "/admin/transportations/:id/edit" => "transportations#edit", via: :get
  
  
 # namespace :admin do
  #  resources :pages
  #end
  
  
  resources :admin
  # Sitemaps
  match "/site2" => "pages#sitemapIII", via: :get
  match "/site1" => "pages#sitemapII", via: :get
  match "/site" => "pages#sitemapI", via: :get
  
  match "/about-us" => "pages#about_us", via: :get
  match "/faqs" => "pages#faqs", via: :get
  match "/landing" => "pages#landing", via: :get
  match "/thankyou" => "pages#thankyou", via: :get

  # get '*path' => "activities#index"
  root :to => "activities#index"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
