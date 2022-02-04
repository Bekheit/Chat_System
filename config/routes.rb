Rails.application.routes.draw do
  namespace 'api' do
    
    match 'applications/:app_token/chats', to: 'chats#index', via: 'get'
    match 'applications/:app_token/chats', to: 'chats#create', via: 'post'
    match 'applications/:app_token/chats/:chat_no', to: 'chats#show', via: 'get'
    match 'applications/:app_token/chats/:chat_no', to: 'chats#destroy', via: 'delete'
    match 'applications/:app_token/chats/:chat_no', to: 'chats#update', via: 'put'

    match 'applications/:app_token/chats/:chat_no/messages', to: 'messages#index', via: 'get'
    match 'applications/:app_token/chats/:chat_no/messages', to: 'messages#create', via: 'post'
    match 'applications/:app_token/chats/:chat_no/messages/:message_no', to: 'messages#show', via: 'get'
    match 'applications/:app_token/chats/:chat_no/messages/:message_no', to: 'messages#destroy', via: 'delete'
    match 'applications/:app_token/chats/:chat_no/messages/:message_no', to: 'messages#update', via: 'put'
    match 'applications/:app_token/chats/:chat_no/messages/contain/:message', to: 'messages#contain', via: 'get'

    resources :applications
    
    match "users/login", to: "users#login", via: 'post'
    match "users/auto_login", to: "users#auto_login", via: 'get'
    match 'users', to: 'users#index', via: 'get'
    match 'users', to: 'users#create', via: 'post'
    match 'users/:username', to: 'users#show', via: 'get'
    match 'users/:username', to: 'users#destroy', via: 'delete'
    match 'users/:username', to: 'users#update', via: 'put'


  end
end
