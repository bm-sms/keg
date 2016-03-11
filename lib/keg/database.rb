require 'keg'
require 'toml'

module Keg
  class Database
    def initialize(root)
      @root = root
      @configuration = Configuration.new(root)
    end

    def switch(db_name)
      path = File.join(databases_path, db_name)

      if !Dir.exist?(path) || db_name.empty?
        abort "Error: No such directroy `#{db_name}`. Please enter a correct DB name."        
      end  
      
      @configuration.save_db_name(db_name)
      
    end

    def contents(filename)
      check_database_exist
      path = File.join(current_path, filename+'.toml')
      if File.exists?(path)
        TOML.load_file(path)
      else
        abort "Error: No such file `#{filename}`. Please enter a correct file name."
      end
    end

    def current
      db_name = @configuration.load_db_name
      if blank?(db_name)
        abort "Error: DB does not set. Make sure that `keg switch DB_NAME`."
      end

      db_name
    end

    def each
      check_database_exist
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

    def blank?(obj)
      obj.nil? || obj.empty?
    end

    def check_database_exist
      unless Dir.exists?(current_path)
        abort "Error: Current DB is unknown directory `aaaa`. Make sure that `keg switch DB_NAME`.\n"
      end
    end
  end
end