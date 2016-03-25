require 'keg'

module Keg
  class Configuration
    def initialize(root)
      @root = root
    end

    def save(name)
      config = { 'database' => name }
      File.write(config_path, config.to_yaml)
    end

    def load
      begin
        @config = YAML.load_file(config_path)
      rescue
        save ''
      end
      unless database_does_set?
        abort 'Error: Database does not set. You should set a database.'
      end

      @config['database']
    end

    def config_path
      File.join(@root, '.keg', 'config.yml')
    end

    def database_does_set?
      return false unless @config # when @config is nil or false
      return false if @config['database'].empty?
      return true
    end
  end
end
