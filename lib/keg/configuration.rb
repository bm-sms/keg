require 'keg'

module Keg
  class Configuration
    def initialize(root)
      @root = root
    end

    def save(name)
      config = { "database" => name }
      File.write(config_path, config.to_yaml)
    end

    def load
      begin
        config = YAML.load_file(config_path)
      rescue
        File.write(config_path, '')
      end
      config['database'] if config
    end

    def config_path
      File.join(@root, '.keg', 'config.yml')
    end
  end
end
