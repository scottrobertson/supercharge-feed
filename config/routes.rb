Rails.application.routes.draw do


  root to: 'application#health'

  get '/changes', to: 'changes#index'
end
