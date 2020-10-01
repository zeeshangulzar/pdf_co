Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/api/convert/*end_point", to: "convert#show"
  get "/api/render_image/*end_point", to: "render_image#show"

  get 'api/document_parser',to: 'document_parser#index'
  get 'api/document_parser/templates',to: 'document_parser#templates'
  get 'api/document_parser/template/:id/results',to: 'document_parser#results'
end
