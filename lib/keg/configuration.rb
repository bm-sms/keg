require 'keg'
require 'yaml'

module Keg
  module Configuration
    def self.save_db_name(name)
      config = { "database" => name }
      File.write(config_path, config.to_yaml)
    end

    def self.load_db_name
      config = YAML.load_file(config_path)
      config['database'] if config
    end

    private

    def self.config_path
      File.join(ENV["HOME"], '.keg', 'config.yml')
    end
  end
end