require 'keg'
require 'toml'

module Keg
  class Database
    def initialize(root)
      @root = root
      @configuration = Configuration.new(@root)
    end

    def switch(db_name)
      @configuration.save_db_name(db_name)
    end

    def contents(filename)
      path = File.join(current_path, filename+'.toml')
      TOML.load_file(path)
    end

    def current
      @configuration.load_db_name
    end

    def each
      Dir.glob("#{current_path}/**/*.toml") do |path|
          yield TOML.load_file(path)
      end
    end

    def current_path
      File.join(databases_path, current)
    end

    def databases_path
      File.join(@root, '.keg', 'databases')
    end
  end
end