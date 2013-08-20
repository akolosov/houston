# Rails.application.config.sorcery.submodules = [:user_activation, :http_basic_auth, :remember_me, :reset_password, :session_timeout, :brute_force_protection, :activity_logging, :external]

Rails.application.config.sorcery.submodules = [:remember_me, :session_timeout, :brute_force_protection, :activity_logging]

Rails.application.config.sorcery.configure do |config|

  config.session_timeout = 12.hour
  config.session_timeout_from_last_action = false

  config.user_config do |user|
    user.username_attribute_names                     = [:username, :email]
    user.subclasses_inherit_config                    = true

    user.activity_timeout                             = 12.hour
    user.remember_me_for                              = 2.week

    user.consecutive_login_retries_amount_limit       = 10
    user.login_lock_time_period                       = 2.minutes
  end

  config.user_class = User
end
