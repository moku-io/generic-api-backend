Airbrake.configure do |config|
  config.api_key = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
  config.host    = 'errors.moku.io'
  config.port    = 80
  config.secure  = config.port == 443
end



#TODO When upgrading to Airbrake 5, this can be removed since it has been integrated https://github.com/airbrake/airbrake#delayedjob
# https://gist.github.com/2223758
module Delayed
  module Plugins
    class Airbrake < Plugin
      module Notify
        def error(job, error)
          ::Airbrake.notify_or_ignore(
              :error_class   => error.class.name,
              :error_message => "#{error.class.name}: #{error.message}",
              :parameters    => {
                  :failed_job => job.inspect,
              }
          )
          super if defined?(super)
        end
      end

      callbacks do |lifecycle|
        lifecycle.before(:invoke_job) do |job|
          payload = job.payload_object
          payload = payload.object if payload.is_a? Delayed::PerformableMethod
          payload.extend Notify
        end
      end
    end
  end
end

Delayed::Worker.plugins << Delayed::Plugins::Airbrake