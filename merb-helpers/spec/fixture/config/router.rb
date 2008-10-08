Merb.logger.info("Compiling routes...")
Merb::Router.prepare do
  resources :fake_models
  resources :obj

  default_routes
end
