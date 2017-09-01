# Rails API backend preconfigured

> To goal of this project is to have a production-ready deploy of an Rails 4 API backend in a few minutes.

It is a blank Rails app, preconfigured with:
- basic authentication via token ([Devise] + [CanCan] + [Devise Token Auth]);
- full deploy setup ([Capistrano] + [nginx] + [puma]);
- auto generate SSL certificate for HTTPS (and auto renew) with [Let's Encrypt]﻿; 
- gems for API testing and documentation ([RSpec API documentation] + [Apitome]);
- basic administration backend ([ActiveAdmin]);
- CORS and URL regex ([rack-cors]);
- API versioning via headers.


Deployment stack is the following:
- Rails 5;
- Capistrano 3;
- nginx configured via Capistrano task;
- Puma configured via Capistrano task;
- crontab with [whenever];
- asynchronous jobs with [delayed-job]﻿;
- auto backups for PostgreSQL;
- environment variables with [figaro];
- error notification with [airbrake]﻿;
- both production and staging environments configured for Capistrano/nginx/puma.


See wiki article on how setup the server accordingly (TODO).


## Getting started
- copy entire folder (including hidden file .rspec)
- rename project name module
- nome git
- nome database
- update application.yml da application.example.yml
- nome app su deploy.rb 
- indirizzo server
- setup Airbrake
- edit this README

And then:
```sh
rake db:create db:migrate db:seed
RAILS_ENV=test rake db:create db:migrate 
rake docs:generate:ordered
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request



[Devise]:https://github.com/plataformatec/devise
[CanCan]:https://github.com/ryanb/cancan
[Devise Token Auth]:https://github.com/lynndylanhurley/devise_token_auth
[Capistrano]:https://github.com/capistrano/capistrano
[nginx]:http://nginx.org/
[puma]:https://github.com/puma/puma
[Let's Encrypt]:https://letsencrypt.org
[RSpec API documentation]:https://github.com/zipmark/rspec_api_documentation
[Apitome]:https://github.com/modeset/apitome
[ActiveAdmin]:https://github.com/gregbell/active_admin
[rack-cors]:https://github.com/cyu/rack-cors
[whenever]:https://github.com/javan/whenever
[delayed-job]:https://github.com/collectiveidea/delayed_job
[Figaro]:https://github.com/laserlemon/figaro
[airbrake]:https://github.com/airbrake/airbrake





# Basic commands

## Import sample data for development purpose
```sh
rake dev_setup:import_sample_data
```

## Deploy last develop branch in staging environment
```sh
cap staging deploy
```

## Deploy revision a56ffeaed78a80a6d3afebfeaee1c1e4da3775b9 in staging environment
```sh
REVISION=f37d74ab7ec1fba90e21444299000128e7783a86 cap staging deploy
```

## Deploy a feature branch (not local branch, you have to publish with git-flow publish)
```sh
REVISION=feature/ZAT-557-capistrano-setup cap staging deploy
```

## Deploy last master branch in production environment:
```sh
REVISION=master cap production deploy
```
Notice: it's strongly suggested to make a revision with git-flow release


## Extra commands
### Restart
```sh
cap <env> deploy:restart
```

### Restart nginx
```sh
cap <env> nginx:restart
cap <env> nginx:reload
```

### List Capistrano tasks
```sh
cap -vT
```

### Logs
Staging:
```sh
ssh deploy@serveraddress.com
cd ~/apps/appname_production/current/log/
```

Production
```sh
ssh deploy@serveraddress.com
cd ~/apps/appname_production/current
```

### Console
Staging:
```sh
ssh deploy@stagingddress.com
cd ~/apps/appname_staging/current
RAILS_ENV=staging bundle exec rails c
```

Production:
```sh
ssh deploy@serveraddress.com
cd ~/apps/appname_production/current
RAILS_ENV=production bundle exec rails c
```


### Clear delayed jobs queue
```sh
ssh deploy@stagingddress.com
cd ~/apps/appname_staging/current
RAILS_ENV=staging bundle exec rake jobs:clear
```


# Frontend

## Password reset

[Password reset flow]

- ng-token-auth will [POST /api/auth/password] with two params: email and redirect_url.
- Backend will send an email to the user with a reset url.
- When user click on the link in the email, backend validates the token and redirect to frontend (redirect_url), passing a 6 hours temporary session (uid, token, client_id...) that let the user to change his password.



[Password reset flow]: https://github.com/lynndylanhurley/ng-token-auth#password-reset-flow
[POST /api/auth/password]: http://localhost:3017/docs/user/password_reset