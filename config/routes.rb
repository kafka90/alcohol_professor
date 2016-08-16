Rails.application.routes.draw do
  
  devise_for :users
  
  root :to => "intro#intro_page"
   get ':controller(/:action(/:id))'
  post ':controller(/:action(/:id))'

end
