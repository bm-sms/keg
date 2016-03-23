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
      path = File.join(current_path, filename+'.toml')

      unless File.exists?(path)
        abort "Error: No such file `#{filename}`. Please enter a correct file name."
      end

      TOML.load_file(path)
    end

    def select_all
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
        #todo: fixed massage
        abort "Error: Current DB is unknown directory `#{@database}`. Make sure that `keg switch DB_NAME`."
      end
    end
  end
end
