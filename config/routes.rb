# frozen_string_literal: true

Rails.application.routes.draw do
  resources :follows
  resources :likes, except: %i[new]
  resources :comments, except: %i[new]
  resources :posts

  post '/graphiql/graphql', to: 'graphql#execute'  
  # if Rails.env.development?
  #   mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "graphql#execute"
  # end

  devise_for :user
  authenticate :user, ->(u) { u.role_is?('admin') } do
    mount Blazer::Engine, at: 'blazer', as: 'blazer'
    # mount Sidekiq::Web => 'sidekiq', as: 'sidekiq'
    mount RailsAdmin::Engine => 'admin', as: 'rails_admin'
    mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: 'graphql#execute'
    mount RailsPerformance::Engine, at: 'site_performance', as: 'site_performance'
  end

  post 'set_theme', to: 'home#set_theme', as: 'set_theme'
  post 'act_as_normal', to: 'home#act_as_normal', as: 'act_as_normal'
  get 'home/index'
  get 'home/about'
  get 'home/contact'
  root to: "home#index"
end
