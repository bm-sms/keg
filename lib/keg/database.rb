require 'keg'
require 'toml'

module Keg
  module Database
    def self.switch(db_name)
      path = File.join(root_path, db_name)
      if File.directory?(path)
        Keg::Configuration.save_db_name(db_name)
      end
    end

    def self.contents(filename)
      path = File.join(db_path, filename+'.toml')
      if File.exists?(path)
        TOML.load_file(path)
      end
    end

    def self.current
      Keg::Configuration.load_db_name
    end

    def self.each
      Dir.glob("#{db_path}/**/*.toml") do |path|
          yield TOML.load_file(path)
      end
    end

    private

    def self.db_path
      File.join(root_path, current)
    end

    def self.root_path
      File.join(ENV["HOME"], '.keg', 'databases')
    end
  end
end