require File.expand_path('../boot', __FILE__)

require 'csv'
require 'rails/all'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(assets: %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module Houston
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Ekaterinburg'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = 'utf-8'

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Use SQL instead of Active Record's schema dumper when creating the database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    # config.active_record.schema_format = :sql

    # Enforce whitelist mode for mass assignment.
    # This will create an empty whitelist of attributes available for mass-assignment for all models
    # in your app. As such, your models will need to explicitly whitelist or blacklist accessible
    # parameters by using an attr_accessible or attr_protected declaration.
    # config.active_record.whitelist_attributes = true

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

    # internal constants
    config.incedent_created  = 1
    config.incedent_played   = 2
    config.incedent_paused   = 3
    config.incedent_stoped   = 4
    config.incedent_rejected = 5
    config.incedent_solved   = 6
    config.incedent_closed   = 7
    config.incedent_waited   = 8

    # class of service time
    # type_id -> priority_id -> reaction_hours, autoclose_hours, escalation_hours, performance_hours, review_hours
    config.class_of_service_time = { '1' => { '1' => [48, 8, 32, 48, 24], '2'  => [32, 8, 24, 32, 24], '3'  => [24, 8, 16, 24, 16], '4'  => [16, 8, 8, 16, 16], '5'  => [8, 8, 4, 8, 4] },
                                     '2' => { '1' => [48, 8, 32, 48, 24], '2'  => [32, 8, 24, 32, 24], '3'  => [24, 8, 16, 24, 16], '4'  => [16, 8, 8, 16, 16], '5'  => [8, 8, 4, 8, 4] },
                                     '3' => { '1' => [48, 8, 32, 48, 24], '2'  => [32, 8, 24, 32, 24], '3'  => [24, 8, 16, 24, 16], '4'  => [16, 8, 8, 16, 16], '5'  => [8, 8, 4, 8, 4] },
                                     '4' => { '1' => [48, 8, 32, 48, 24], '2'  => [32, 8, 24, 32, 24], '3'  => [24, 8, 16, 24, 16], '4'  => [16, 8, 8, 16, 16], '5'  => [8, 8, 4, 8, 4] }}

    config.app_name = 'Houston'
    config.version = '0.17.1'
    config.email = 'houston@taxinonstop.ru'
  end
end
