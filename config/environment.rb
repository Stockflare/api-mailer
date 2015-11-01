ENV['RACK_ENV'] ||= 'development'

spec = "environments/#{ENV['RACK_ENV']}.rb"
require spec if File.exist? spec

require File.expand_path('../application', __FILE__)

Dir["#{File.expand_path('../initializers', __FILE__)}/**/*.rb"].each { |f| require f }
