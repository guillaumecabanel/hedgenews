Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :articles, only: [:index] do
    post 'bookmark', to: 'article_bookmarks#create'
    delete 'bookmark', to: 'article_bookmarks#destroy'
  end

  # Styleguide
  get 'styleguide', to:'pages#styleguide'

  get 'team', to: 'pages#team'

  get 'about', to: 'pages#about'

  # Test api aylien
  get 'search', to: 'aylien_tests#search'
  get 'results', to: 'aylien_tests#results'

end
