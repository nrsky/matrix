Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/routes',to: 'routes#download'
  post '/routes', to: 'routes#upload'
end
