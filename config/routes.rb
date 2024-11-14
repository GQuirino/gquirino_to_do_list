Rails.application.routes.draw do
  get "static/index"
  mount ToDoApp::Base => "/"

  # Route the root path to the React app
  root "static#index"

  # Catch-all route to serve the React app for any unknown path
  get "*path", to: "static#index", constraints: ->(req) { !req.xhr? && req.format.html? }
end
