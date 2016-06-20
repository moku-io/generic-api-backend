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

server 'my-new-app.moku.io', user: 'deploy', roles: %w{web app db}, primary: true, my_property: :my_value

# Nginx settings
set :nginx_domains, 'my-new-app.moku.io'
set :redirect_address_without_www, false  # It strips the 'www.' from the first domain in :nginx_domains and add an auto-redirect from domain.com to www.domain.com (both http and https).

# Puma settings
set :puma_threads, [0, 4]
set :puma_workers, 1

# Disable multithreading  # http://omegadelta.net/2013/06/16/puma-on-heroku-with-mri/
# Remember to enable preload_app! to speed things up. But check glitches with hot-restart.
# set :puma_threads, [1, 1]
# set :puma_workers, 5

# Guidelines:
# - One worker per core
# - Threads to be determined in connection with RAM availability and application and
# - Threads = Connection Pool (database)


# SSL settings
set :nginx_use_ssl, true

set :lets_encrypt_domains, 'my-new-app.moku.io www.my-new-app.moku.io'
set :lets_encrypt_email, 'info@moku.io'

set :nginx_ssl_certificate, 'fullchain.pem'
set :nginx_ssl_certificate_path, "/etc/letsencrypt/live/#{fetch(:lets_encrypt_domains).split(' ').first}"
set :nginx_ssl_certificate_key, 'privkey.pem'
set :nginx_ssl_certificate_key_path, "/etc/letsencrypt/live/#{fetch(:lets_encrypt_domains).split(' ').first}"
set :nginx_ssl_certificate_ca, 'chain.pem'  # As nginx_ssl_certificate bundle, but without the first one (this domain); https://www.digitalocean.com/community/tutorials/how-to-configure-ocsp-stapling-on-apache-and-nginx
set :nginx_ssl_certificate_ca_path, "/etc/letsencrypt/live/#{fetch(:lets_encrypt_domains).split(' ').first}"
set :nginx_dhparam, 'dhparams.pem'
set :nginx_dhparam_path, "#{shared_path}/ssl"


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
