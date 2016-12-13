Rails.application.routes.draw do
  devise_for :users

    resources :article_bookmarks, only: [:index]


  root to: 'pages#home'

  resources :articles, only: [:index]

  resources :topics

  post 'bookmark', to: 'article_bookmarks#create'
  delete 'bookmark', to: 'article_bookmarks#destroy'

  # Styleguide
  get 'styleguide', to:'pages#styleguide'

  get 'team', to: 'pages#team'

  get 'about', to: 'pages#about'

  # Test api aylien
  get 'search', to: 'aylien_tests#search'
  get 'results', to: 'aylien_tests#results'

end
