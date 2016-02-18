require 'keg'
require 'toml'

module Keg
  class Database
    def initialize(root)
      @root = root
    end

    def switch(db_name)
      return if db_name.empty?
      
      path = File.join(databases_path, db_name)
      if File.directory?(path)
        Keg::Configuration.save_db_name(db_name)
      end
    end

    def contents(filename)
      path = File.join(current_path, filename+'.toml')
      if File.exists?(path)
        TOML.load_file(path)
      end
    end

    def current
      Keg::Configuration.load_db_name
    end

    def each
      Dir.glob("#{current_path}/**/*.toml") do |path|
          yield TOML.load_file(path)
      end
    end

    private

    def current_path
      File.join(databases_path, current)
    end

    def databases_path
      File.join(@root, '.keg', 'databases')
    end
  end
end