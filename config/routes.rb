Rails.application.routes.draw do

  resources :rental_bookings
  resources :countries
  resources :contacts
  resources :calendars do
    member do
      get :export
    end
  end

#####################################
# begin preview namespace
#####################################
  namespace :preview do

  end

#####################################
# begin admin namespace
#####################################

  namespace :admin do
    get '/' => 'admins#index'
    get 'login' => 'admin_sessions#new'
    get 'documents/(:document_url)' => 'documents#show', :document_url => /\S+/
    get 'documents' => 'documents#index'
    resources :admin_addresses
    resources :admins
    resources :admins_sites
    resources :admin_sessions
    resources :article_posts do
      collection do
        post 'sort'
      end
    end
    resources :articles do
      member do
        patch 'category'
      end
    end
    resources :authors
    resources :article_authors
    resources :artists
    resources :admins_sites
    resources :blog_posts do
      collection do
        post 'sort'
      end
    end
    resources :blogs do
      member do
        patch 'category'
      end
    end
    resources :bookings
    resources :booking_transactions
    resources :calendars do
      member do
        get :import
      end
    end
    resources :carousels
    resources :carousel_slides do
      collection do
        post 'sort'
      end
      collection do
        get 'edit_all'
      end
    end
    resources :categories do
      member do
        patch 'image'
      end
      member do
        patch 'article'
      end
    end
    resources :content_group_clones, only: [:new,:create]
    resources :content_groups do
      member do
        patch 'category'
      end
    end
    resources :content_admins do
      collection do
        post 'sort'
      end
    end
    resources :content_group_items do
      collection do
        post 'sort'
      end
    end
    resources :content_group_text_items do
      collection do
        post 'sort'
      end
    end
    resources :container_clones, only: [:new,:create]
    resources :containers
    resources :containers_pages do
      collection do
        post 'sort'
      end
    end
    resources :container_rows do
      collection do
        post 'sort'
      end
    end
    resources :designers
    resources :domains
    resources :dropdowns
    resources :dropdown_items do
      collection do
        post 'sort'
      end
    end
    resources :errors
    resources :images do
      member do
        patch 'category'
      end
    end
    resources :image_batches
    resources :image_batch_images
    resources :image_batch_uploads, only: [:create]
    resources :image_crops
    resources :image_optimizations
    resources :image_previews
    resources :image_publishes, only: [:create]
    resources :image_watermarks
    resources :image_groups
    resources :image_group_items do
      collection do
        post 'sort'
      end
      collection do
        get 'edit_all'
      end
    end
    resources :image_group_uploads
    resources :list_group_items do
      collection do
        post 'sort'
      end
    end
    resources :list_group_clones, only: [:new,:create]
    resources :list_groups
    resources :mail_servers
    resources :mail_templates
    resources :media  do
      member do
        patch 'category'
      end
    end
    resources :navigation_items do
      collection do
        post 'sort'
      end
    end
    resources :navigations
    resources :palettes
    resources :palette_colors
    resources :pages
    resources :payment_gateways
    resources :payment_methods
    resources :payment_types
    resources :rental_booking_instructions
    resources :rental_payment_methods do
      collection do
        post 'sort'
      end
    end
    resources :rentals
    resources :row_columns do
      collection do
        post 'sort'
      end
    end
    resources :site_tags do
      collection do
        post 'sort'
      end
    end
    resources :sites
    resources :songs
    resources :themes do
      member do
        get 'edit_scss_production'
      end
      member do
        get 'edit_scss_workspace'
      end
      member do
        put 'sync_css'
      end
    end
    resources :theme_colors
    resources :theme_icons
    resources :user_addresses
    resources :users
    resources :videos
    resources :watermarks
  end

  #####################################
  # end admin namespace
  #####################################

  resources :media
  resources :posts
  resources :artists
  resources :authors
  resources :errors
  resources :images
  resources :users

  # Added to match before :nice_url for pages
  get '/rails/active_storage/blobs/:signed_id/*filename(.:format)' => 'active_storage/blobs#show'
  get '/rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format)' => 'active_storage/representations#show'
  get '/rails/active_storage/disk/:encoded_key/*filename(.:format)' => 'active_storage/disk#show'
  put '/rails/active_storage/disk/:encoded_token(.:format)' => 'active_storage/disk#update'
  post '/rails/active_storage/direct_uploads(.:format)' => 'active_storage/direct_uploads#create'
  get '/.well-known/acme-challenge/:id' => 'pages#letsencrypt'
  get '/articles' => 'articles#index'
  get '/articles/(:content_url)' => 'articles#show', :content_url => /\S+/
  get '/image_previews/*' => 'pages#static_asset'
  get '/documents/*' => 'pages#static_asset'
  get '/(:nice_url)' => 'pages#show', :nice_url => /\S+/
  root 'pages#show'

end
