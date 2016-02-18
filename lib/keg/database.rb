require 'keg'
require 'toml'

module Keg
  module Database
    def self.switch(db_name)
      return if db_name.empty?
      
      path = File.join(databases_path, db_name)
      if File.directory?(path)
        Keg::Configuration.save_db_name(db_name)
      end
    end

    def self.contents(filename)
      path = File.join(current_path, filename+'.toml')
      if File.exists?(path)
        TOML.load_file(path)
      end
    end

    def self.current
      Keg::Configuration.load_db_name
    end

    def self.each
      Dir.glob("#{current_path}/**/*.toml") do |path|
          yield TOML.load_file(path)
      end
    end

    private

    def self.current_path
      File.join(databases_path, current)
    end

    def self.databases_path
      File.join(ENV["HOME"], '.keg', 'databases')
    end
  end
end