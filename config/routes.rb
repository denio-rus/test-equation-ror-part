Rails.application.routes.draw do
  root to: "equations#request_form"
  
  resources :equations, only: [] do
    collection do
      get :request_form
      post :solve
      get :result
    end
  end
end
