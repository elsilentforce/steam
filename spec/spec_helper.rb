require 'simplecov'
require 'codeclimate-test-reporter'
require 'coveralls'

SimpleCov.start do
  formatter SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    CodeClimate::TestReporter::Formatter,
    Coveralls::SimpleCov::Formatter
  ]

  add_filter 'spec/'

  add_group "Middlewares",    "lib/locomotive/steam/middlewares"
  add_group "Liquid Filters", "lib/locomotive/steam/liquid/filters"
  add_group "Liquid Tags",    "lib/locomotive/steam/liquid/tags"
  add_group "Liquid Drops",   "lib/locomotive/steam/liquid/drops"
  add_group "Repositories",   "lib/locomotive/steam/repositories"
  add_group "Services",       "lib/locomotive/steam/services"
end

require 'rubygems'
require 'bundler/setup'

require 'i18n-spec'

require_relative '../lib/locomotive/steam'
require_relative '../lib/locomotive/steam/repositories/filesystem'
require_relative 'support'

Locomotive::Steam.configure do |config|
  config.mode         = :test
  config.assets_path  = File.join(File.expand_path(File.dirname(__FILE__)), 'fixtures', 'default', 'public')
end

RSpec.configure do |config|
  config.include Spec::Helpers

  config.filter_run focused: true
  config.run_all_when_everything_filtered = true

  config.before(:all) { remove_logs; setup_common }
  config.before { reset! }
  config.after  { reset! }
  config.order = 'random'
end
