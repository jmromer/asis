# frozen_string_literal: true

Rails.application.routes.draw do
  root 'welcome#index'

  get 'manuscript_status', to: 'manuscript_status#search', as: :manuscript_status_search

  namespace :admin do
    resources :manuscripts, only: [:index]
  end
end
