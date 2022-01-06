# frozen_string_literal: true

Rails.application.routes.draw do
  resources :gachas, only: %i[index show destroy]
  root to: 'gachas#index'
end
