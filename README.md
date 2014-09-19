# Generic Rails API backend

> To goal of this project is to have a production-ready deploy of an Rails 4 API backend in a few minutes.

It is preconfigured with:
- authentication ([Devise] + [CanCan]);
- easy preconfigured deployment ([Capistrano] + [nginx] + [puma]);
- easy API testing and documentation ([RSpec API documentation] + [Raddocs]);
- basic administration backend ([ActiveAdmin]);
- CORS preconfigured ([rack-cors]);
- API versioning via headers.


Deployment stack is the following:
- Rails 4.1
- Capistrano 3;
- nginx configured via Capistrano task;
- Puma configured via Capistrano task;
- crontab with [whenever]
- environment variables with [Figaro];
- both production and staging environments configured for Capistrano/nginx/puma;
- configurable exception notification via email ([exception_notification]).


See wiki article on how setup the server accordinly (TODO).


## Getting started
TODO


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request



[Devise]:https://github.com/plataformatec/devise
[CanCan]:https://github.com/ryanb/cancan
[Capistrano]:https://github.com/capistrano/capistrano
[nginx]:http://nginx.org/
[puma]:https://github.com/puma/puma
[RSpec API documentation]:https://github.com/zipmark/rspec_api_documentation
[Raddocs]:https://github.com/smartlogic/raddocs
[ActiveAdmin]:https://github.com/gregbell/active_admin
[rack-cors]:https://github.com/cyu/rack-cors
[exception_notification]:https://github.com/smartinez87/exception_notification
[whenever]:https://github.com/javan/whenever
[Figaro]:https://github.com/laserlemon/figaro