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
      unless db_does_set?
        abort 'Error: DB does not set. Make sure that `keg switch DB_NAME`.'
      end

      @config['database']
    end

    def config_path
      File.join(@root, '.keg', 'config.yml')
    end

    def db_does_set?
      return false unless @config
      return false if @config['database'].empty?
      return true
    end
  end
end
