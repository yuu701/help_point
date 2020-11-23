# server "db.example.com", user: "deploy", roles: %W{db}
server "3.139.92.227", user: "yuu", roles: %w{app db web}

set :rails_env, "production"
set :unicorn_rack_env, "production"

#role-based syntax
#=================