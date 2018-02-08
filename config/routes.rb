# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace 'v2' do
    resources :identifiers, only: %i[index show create]
  end

  # legacy routes
  post '/suri2/namespaces/druid/identifiers' => 'v2/identifiers#create'
  # this is an old path we use for monitoring
  get '/suri2/namespaces' => 'ok_computer/ok_computer#index'
end
