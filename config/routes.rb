Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, :controllers => { registrations: 'registrations', :omniauth_callbacks => 'users/omniauth_callbacks' } #use custom registrations controller override

  resources :stories do
    resources :chapters, only: :new #nested chapter creation
  end
  resources :chapters
  resources :characters
  resources :genres, only: [:index, :show]
  resources :audiences, only: [:index, :show]
  resources :comments, only: [:create, :edit, :update, :destroy]

  #delete image routes
  patch 'writers/delete_writer_avatar', to: 'writers#delete_avatar', as: 'delete_writer_avatar'
  patch 'stories/:id/delete_story_cover', to: 'stories#delete_cover', as: 'delete_story_cover'
  patch 'characters/:id/delete_character_portrait', to: 'characters#delete_portrait', as: 'delete_character_portrait'

  #writer isn't a model, just an alias for devise user to separate logic
  scope '/writers' do
    get 'profile' => 'writers#profile'
    get 'edit_profile' => 'writers#edit_profile'
    patch 'update_profile' => 'writers#update_profile'
    get 'my_stories' => 'writers#my_stories'
  end

  resources :writers, only: [:index, :show] do
    #nested resources
    resources :stories, only: [:index]
    resources :characters, only: [:index]
    resources :chapters, only: [:index]
  end

  get 'search', to: 'searches#search'

  root 'pages#index'
end
