require File.expand_path('../boot', __FILE__)

# Core manages the loading of the system.
#
# @note This file should not be edited directly. It is extended and
#   consumed via {Application} (./application.rb). All customizations
#   and overrides should be written in that class.
class Core
  cattr_accessor :api
  self.api = File.expand_path('../api', __FILE__)

  cattr_accessor :config_dir
  self.config_dir = File.expand_path('../', __FILE__)

  cattr_accessor :load_paths
  self.load_paths = %w(models lib lib/publishers controllers helpers)

  def self.load!
    ActiveSupport::Dependencies.autoload_paths += app_load_paths
    require api
  end

  def self.app_load_paths
    load_paths.collect { |l| "app/#{l}" }
  end
end
