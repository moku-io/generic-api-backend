# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.

# role :app, %w{deploy@example.com}
# role :web, %w{deploy@example.com}
# role :db,  %w{deploy@example.com}


# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server definition into the
# server list. The second argument is a, or duck-types, Hash and is
# used to set extended properties on the server.

server 'my-new-app.moku.io', user: 'deploy', roles: %w{web app db}, my_property: :my_value

# Nginx settings
set :nginx_domains, 'my-new-app.moku.io'
set :nginx_use_ssl, true

# Name of SSL certificate file
set :nginx_ssl_certificate, 'xxx_com-bundle.crt'
set :nginx_ssl_certificate_path, "#{shared_path}/ssl"
set :nginx_ssl_certificate_key, 'xxx_com.key'
set :nginx_ssl_certificate_key_path, "#{shared_path}/ssl"
set :nginx_ssl_certificate_ca, 'intermediate_and_ca.crt'  # As nginx_ssl_certificate bundle, but without the first one (this domain); https://www.digitalocean.com/community/tutorials/how-to-configure-ocsp-stapling-on-apache-and-nginx
set :nginx_ssl_certificate_ca_path, "#{shared_path}/ssl"

# Puma settings
set :puma_threads, [0, 4]
set :puma_workers, 1

# Disable multithreading  # http://omegadelta.net/2013/06/16/puma-on-heroku-with-mri/
# set :puma_threads, [1, 1]
# set :puma_workers, 5

# Guidelines:
# - One worker per core
# - Threads to be determined in connection with RAM availability and application and
# - Threads = Connection Pool (database)


# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult[net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start).
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# And/or per server (overrides global)
# ------------------------------------
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
