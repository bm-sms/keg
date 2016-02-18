require 'keg'
require 'yaml'

module Keg
  class Configuration
    def initialize(root)
      @root = root
    end

    def save_db_name(name)
      config = { "database" => name }
      File.write(config_path, config.to_yaml)
    end

    def load_db_name
      config = YAML.load_file(config_path)
      config['database'] if config
    end

    private

    def config_path
      File.join(@root, '.keg', 'config.yml')
    end
  end
end