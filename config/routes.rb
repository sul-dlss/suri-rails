# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :identifiers, only: %i[index show create]

  # legacy routes
  post '/suri2/namespaces/druid/identifiers' => 'identifiers#create'
  get '/suri2/namespaces' => 'ok_computer/ok_computer#index'
end
