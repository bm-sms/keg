require 'keg'
require 'toml'

module Keg
  class Database
    def initialize(root)
      @root = root
    end

    def use(name)
      @database = name
      check_database_exist
    end

    def select(filename)
      check_database_exist
      path = File.join(current_path, filename+'.toml')
      if File.exists?(path)
        TOML.load_file(path)
      else
        abort "Error: No such file `#{filename}`. Please enter a correct file name."
      end
    end

    def select_all
      check_database_exist
      Dir.glob("#{current_path}/**/*.toml").map do |path|
          TOML.load_file(path)
      end
    end

    def current_path
      File.join(databases_path, @database)
    end

    def databases_path
      File.join(@root, '.keg', 'databases')
    end

    def db_does_set?
      name = @configuration.load
      unless name.nil? || name.empty?
        return true
      else
        return false
      end
    end

    def check_database_exist
      unless Dir.exists?(current_path)
        abort "Error: Current DB is unknown directory `#{@database}`. Make sure that `keg switch DB_NAME`.\n"
      end
    end
  end
end
