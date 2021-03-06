Rails.application.routes.draw do
  resources :users
  root "upload_excel#show"
  get 'upload_excel/show'
 
  post 'excel/send_data' => 'upload_excel#get_data'
  get 'excel/show' => 'upload_excel#show'
  post 'excel/delete' => 'upload_excel#delete_data'
  get 'excel/download' => 'upload_excel#download'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
