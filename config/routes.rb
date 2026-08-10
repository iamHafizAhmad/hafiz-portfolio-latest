Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Ruby/Rails interview practice days - add "day3", "day4"... here as you go
  get "day1", to: "days#day1"
  get "day2", to: "days#day2"
  get "day3", to: "days#day3"
  get "day4", to: "days#day4"
  get "day5", to: "days#day5"
  get "day6", to: "days#day6"
  get "day7", to: "days#day7"
  get "day8", to: "days#day8"
  get "day9", to: "days#day9"
  get "day10", to: "days#day10"

  # Defines the root path route ("/")
  root "days#index"
end
