# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :identifiers, only: %i[index show create]

  # legacy routes
  post '/namespaces/druid/identifiers' => 'identifiers#create'
  get '/namespaces' => 'ok_computer/ok_computer#index'
end
