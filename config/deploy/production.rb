server "13.229.114.123", user: "ubuntu", roles: %w(web app db), primary: true

set :stage, :production
set :rails_env, :production
set :deploy_to, "/home/ubuntu/cupcake/"
# default branch master
# set :branch, ENV['BRANCH'] if ENV['BRANCH']
set :ssh_options, {
  forward_agent: true,
  auth_methods: %w[publickey],
  keys: %w(../.ssh/giveme.cer)
}