Rails.application.routes.draw do
  root to: 'pages#home'

  resources :articles, only: [:index]

  # Styleguide
  get 'styleguide', to:'pages#styleguide'

  get 'team', to: 'pages#team'

  get 'about', to: 'pages#about'

end
