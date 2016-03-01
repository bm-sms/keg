require 'keg'
require 'thor'

module Keg
  class CLI < Thor
    DEFAULT_FORMAT = 'json'

    def initialize(*args)
      super
      @database = Database.new(ENV["HOME"])
    end

    def self.exit_on_failure?
      true
    end

    desc "switch <database_name>", "switching database that you are selected."
    def switch(db_name)
      if @database.switch(db_name)
        puts "switch DataBase `#{db_name}`."
      else
        raise Thor::Error, "Error: No such directroy `#{db_name}`. Please enter a correct DB name."
      end
    end

    desc "show <filename>", "output file contents in current database."
    method_option :format, desc: "json, yaml", default: DEFAULT_FORMAT
    def show(filename)
      check_database 
      check_format(options[:format])

      unless contents = @database.contents(filename)
        raise Thor::Error, "Error: No such file `#{filename}`. Please enter a correct file name."
      end

      formatter = Formatter.create(options["format"])
      
      puts formatter.format(contents) 
    end

    desc "current", "output current database name."
    def current
      check_database

      puts @database.current
    end

    desc "show_all", "output all file contents in current database."
    method_option :format, desc: "json, yaml", default: DEFAULT_FORMAT
    def show_all
      check_database
      check_format(options["format"])

      formatter = Formatter.create(options[:format])

      @database.each do |contents|
        puts formatter.format(contents)
      end
    end

    private

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
        raise Thor::MalformattedArgumentError, "Error: Unavailable format `#{options["format"]}`. Please enter a available format `json` or `yaml`."
      end
    end
  end
end