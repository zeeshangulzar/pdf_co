Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/api/convert/*end_point", to: "convert#show"
  get "/api/render_image/*end_point", to: "render_image#show"
end
