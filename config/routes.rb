Rails.application.routes.draw do
  resources :gachas, only: %i(index show destroy)
end
