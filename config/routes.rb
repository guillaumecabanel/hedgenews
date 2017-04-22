Rails.application.routes.draw do
  devise_for :users

  resources :article_bookmarks, only: [:index]

  root to: 'pages#home'

  resources :articles, only: [:index, :destroy]

  resources :topics do
    member do
      post :publish
    end
  end

  post 'topic_article', to: 'topic_articles#create'

  post 'bookmark', to: 'article_bookmarks#create'
  delete 'bookmark', to: 'article_bookmarks#destroy'

  # Styleguide
  get 'styleguide', to:'pages#styleguide'

  get 'team', to: 'pages#team'

  get 'about', to: 'pages#about'

  # Test api aylien
  get 'search', to: 'aylien_tests#search'
  get 'results', to: 'aylien_tests#results'

  # Sidekiq Web UI, only for admins.
  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end

end
