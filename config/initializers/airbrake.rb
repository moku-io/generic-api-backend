require 'airbrake/delayed_job'

Airbrake.configure do |config|
  config.environment = Rails.env
  config.ignore_environments = %w[development test]

  config.project_id  = 1
  config.project_key = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
  config.host        = 'https://errors.moku.io'
  config.performance_stats = false

  # Add git commit hash to log the current version (Capistrano).
  if File.exist? "#{Rails.root}/REVISION"
    config.app_version = File.read("#{Rails.root}/REVISION").squish
  end

  # Blacklisting.
  # TODO: EXAMPLE
  config.blacklist_keys = %i[name surname fullname gender birthdate social_security_number
                             health_insurance_card]
end

Airbrake.add_filter do |notice|
  # The library supports nested exceptions, so one notice can carry several
  # exceptions.
  if notice[:errors].any? { |error| ['Aws::S3::Errors::NotFound', 'EOFError', 'SocketError', 'Errno::ECONNABORTED', 'Errno::ECONNREFUSED', 'Errno::ECONNRESET', 'Errno::EHOSTUNREACH', 'Errno::EINVAL', 'Errno::ENETUNREACH', 'Errno::ETIMEDOUT', 'Net::HTTPBadResponse', 'Net::HTTPHeaderSyntaxError', 'Net::ProtocolError', 'Net::ReadTimeout', 'Net::OpenTimeout', 'Net::HTTPBadResponse', 'Timeout::Error', 'OpenSSL::SSL::SSLError'].include?(error[:type]) }
    notice.ignore!
  end
end
