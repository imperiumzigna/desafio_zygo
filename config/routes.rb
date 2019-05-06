# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'drinks#index'
  get '/recommend', to: 'drinks#recommend'
  get '/advanced', to: 'drinks#advanced'
  resources :home, only: %i[index]
end
