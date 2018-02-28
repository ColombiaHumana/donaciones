Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # resources :donators
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'donators#new', as: :donators
  post '/', to: 'donators#create'
  get '/:slug', to: 'donators#show', as: :donator
  get '/:slug/pagado', to: 'donators#pagado', as: :donator_pagado
  post '/:slug', to: 'donators#pagado_callback', as: :pagado_callback
  get '/validando', to: 'donators#validating', as: :validating

  get '/responses', to: 'donations#responses', as: :responses
  post '/responses', to: 'donations#save_response', as: :save_response
end
