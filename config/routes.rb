Rails.application.routes.draw do

  scope module: 'merchant' do
    resources :merchants, only: [] do 
      resources :dashboard, only: [ :index ]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
