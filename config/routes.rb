Rails.application.routes.draw do
  root controller: :changes, action: :index
  get '/changes', to: 'changes#index'
end
