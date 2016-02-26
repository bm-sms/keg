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
        warn "Error: No such directroy `#{db_name}`.\nPlease enter a valid DB name."
        return -1
      end
    end

    desc "show filename", "output file contents."
    method_option "format", desc: "json, yaml", default: DEFAULT_FORMAT
    def show(filename)
      return if db_does_not_set?

      unless contents = @database.contents(filename)
        warn "Error: No such file `#{filename}`.\nPlease enter a valid file name."
        return -1
      end

      formatter = Formatter.create(options["format"])
      
      puts formatter.format(contents) 
    end

    desc "current", "show current database name."
    def current
      return -1 if db_does_not_set?

      puts @database.current
    end

    desc "show_all", "output all file contents."
    method_option "format", desc: "json, yaml", default: DEFAULT_FORMAT
    def show_all
      return -1 if db_does_not_set?

      formatter = Formatter.create(options["format"])

      @database.each do |contents|
        puts formatter.format(contents)
      end
    end

    private

    def db_does_not_set?
      db = @database.current
      if db.nil? || db.empty?
        warn "Error: DB does not set.\nMake sure that `keg switch DB_NAME`."
        return true
      else 
        return false
      end
    end
  end
end