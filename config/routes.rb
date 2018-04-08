Rails.application.routes.draw do
  root to: redirect('https://github.com/scottrobertson/supercharge-feed')
  get '/changes', to: 'changes#index'
end
