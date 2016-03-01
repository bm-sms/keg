require 'keg'

module Keg
  class Validator
    def initialize(database)
      @database = database
    end

    def check_dir(db_name)
      path = File.join(@database.databases_path, db_name)
      if db_name.empty? || !Dir.exist?(path)
        raise Thor::Error, "Error: No such directroy `#{db_name}`. Please enter a correct DB name."
      end
    end

    def check_file(filename)
      path = File.join(@database.current_path, "#{filename}.toml")
      if filename.empty? || !File.exist?(path)
        raise Thor::Error, "Error: No such file `#{filename}`. Please enter a correct file name."
      end
    end

    def check_database
      db = @database.current
      if db.nil? || db.empty?
        raise Thor::InvocationError, "Error: DB does not set. Make sure that `keg switch DB_NAME`."
      elsif !Dir.exist?(@database.current_path)
        raise Thor::InvocationError, "Error: Current DB is unknown directory `#{db}`. Make sure that `keg switch DB_NAME`."
      end
    end

    def check_format(format)
      unless Formatter.available_format?(format)
        raise Thor::MalformattedArgumentError, "Error: Unavailable format `#{format}`. Please enter a available format `json` or `yaml`."
      end
    end
  end
end