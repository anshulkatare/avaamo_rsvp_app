Rails.application.routes.draw do
  devise_for :users
  resources :events
  root to: 'dashboard#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :rsvps do
    get :show_all
    put :update_rsvp
    post :create_rsvp
    get :send_rsvp
  end
end
