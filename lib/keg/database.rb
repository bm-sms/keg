require 'keg'
require 'toml'

module Keg
  class Database
    def initialize(root)
      @root = root
      @configuration = Configuration.new(root)
    end

    def use(db_name)
      path = File.join(databases_path, db_name)

      if !Dir.exist?(path) || db_name.empty?
        abort "Error: No such directroy `#{db_name}`. Please enter a correct DB name."        
      end  
      
      @configuration.save_db_name(db_name)
    end

    def select(filename)
      check_database_exist
      path = File.join(current_path, filename+'.toml')

      unless File.exists?(path)
        abort "Error: No such file `#{filename}`. Please enter a correct file name."
      end

      TOML.load_file(path)
    end

    def current
      db_name = @configuration.load_db_name
      if blank?(db_name)
        abort "Error: DB does not set. Please set a database."
      end

      db_name
    end

    def select_all
      check_database_exist
      Dir.glob("#{current_path}/**/*.toml").map do |path|
          TOML.load_file(path)
      end
    end

    def current_path
      File.join(databases_path, current)
    end

    def databases_path
      File.join(@root, '.keg', 'databases')
    end

    def blank?(obj)
      obj.nil? || obj.empty?
    end

    def check_database_exist
      unless Dir.exists?(current_path)
        abort "Error: Current DB is unknown directory `aaaa`. Please set a correct database."
      end
    end
  end
end