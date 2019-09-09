Rails.application.routes.draw do
  root to: "equation#new"
  resources :equations, only: [:show, :new, :create]
end
