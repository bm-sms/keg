require 'keg'
require 'yaml'

module Keg
  module Configuration
    def self.save_db_name(name)
      File.write(path, name)
    end

    def self.load_db_name
      yaml = File.read(path)
      config = Keg::Formatter::Yaml.parse(yaml)
      config['database']
    end

    private

    def self.path
      File.join(root_path, 'config.yml')
    end

    def self.root_path
      File.join(ENV["HOME"], '.keg')
    end

    def self.recover_form_open_error
      unless Dir.exists?(root_path)
        Dir.mkdir(root_path)
      end
      save_db_name('')
    end
  end
end