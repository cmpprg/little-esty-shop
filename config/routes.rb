Rails.application.routes.draw do

  scope module: 'merchant' do
    resources :merchants, only: [] do 
      resources :dashboard, only: [ :index ]
      resources :items, only: [ :index ]
      resources :invoices, only: [ :index ]
    end
  end
end
