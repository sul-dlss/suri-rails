# frozen_string_literal: true

Rails.application.routes.draw do
  resources :identifiers, only: %i[show create]

  # legacy routes
  post '/suri2/namespaces/druid/identifiers' => 'identifiers#create'
  get '/suri2/namespaces' => 'ok_computer/ok_computer#index'
end
