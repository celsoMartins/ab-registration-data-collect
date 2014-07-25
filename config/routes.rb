AbRegistrationDataCollect::Application.routes.draw do
  root :to => "transaction#index"
  get "transaction/index"
end
