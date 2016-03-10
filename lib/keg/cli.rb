require 'keg'
require 'thor'

module Keg
  class CLI < Thor
    DEFAULT_FORMAT = 'json'

    def initialize(*args)
      super
      @database = Database.new(ENV["HOME"])
    end

    desc "switch DB_NAME", "switching database to DB_NAME."
    def switch(db_name)
      if @database.switch(db_name)
        puts "switch DataBase `#{db_name}`."
      else
        abort "Error: No such directroy `#{db_name}`. Please enter a correct DB name."
      end
    end

    desc "show filename", "output file contents."
    method_option "format", desc: "json, yaml", default: DEFAULT_FORMAT
    def show(filename)
      unless database_does_set? 
        abort "Error: DB does not set. Make sure that `keg switch DB_NAME`."
      end
      unless current_database_is_known?
        abort "Error: Current DB is unknown directory. Make sure that `keg switch DB_NAME`."        
      end
      unless Formatter.available_format?(options[:format])
        abort "Error: Unavailable format `#{options[:format]}`. Please enter a available format `json` or `yaml`."
      end

      unless contents = @database.contents(filename)
        abort "Error: No such file `#{filename}`. Please enter a correct file name."
        
      end

      formatter = Formatter.create(options[:format])
      
      puts formatter.format(contents) 
    end

    desc "current", "show current database name."
    def current
      unless database_does_set?
        abort "Error: DB does not set. Make sure that `keg switch DB_NAME`."
      end

      puts @database.current
    end

    desc "show_all", "output all file contents."
    method_option "format", desc: "json, yaml", default: DEFAULT_FORMAT
    def show_all
      unless database_does_set? 
        abort "Error: DB does not set. Make sure that `keg switch DB_NAME`."
      end
      unless current_database_is_known?
        abort "Error: Current DB is unknown directory. Make sure that `keg switch DB_NAME`."        
      end
      unless Formatter.available_format?(options[:format])
        abort "Error: Unavailable format `#{options[:format]}`. Please enter a available format `json` or `yaml`."
      end

      formatter = Formatter.create(options[:format])

      @database.each do |contents|
        puts formatter.format(contents)
      end
    end

    private

    def database_does_set?
      db = @database.current
      !db.nil? && !db.empty?
    end

    def current_database_is_known?
      Dir.exist?(@database.current_path)
    end
  end
end