require 'keg'

module Keg
  module Configuration
    def self.save_db_name(name)
      hash = { "database" => name }
      config = Keg::Formatter::Yaml.format(hash)
      File.write(config_path, config)
    end

    def self.load_db_name
      yaml = File.read(config_path)
      config = Keg::Formatter::Yaml.parse(yaml)
      config['database'] if config
    end

    private

    def self.config_path
      File.join(ENV["HOME"], '.keg', 'config.yml')
    end
  end
end