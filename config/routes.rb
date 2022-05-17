# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'application#home'

  resources :notes, only: [:index, :show, :create, :update, :destroy]
end
