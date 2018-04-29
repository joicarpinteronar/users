Rails.application.routes.draw do

  resources :items
  resources :users

  get 'authorize' => 'users#testSession'


	post 'authenticate', to: 'authentication#authenticate'

	get 'search', to: 'users#search'

  get 'logout', to: 'users#logout'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
