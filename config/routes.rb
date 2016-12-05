Rails.application.routes.draw do
  root to: 'pages#home'

  resources :articles, only: [:index]

  # Styleguide
  get 'styleguide', to:'pages#styleguide'

end
