require 'keg'
require 'thor'

module Keg
  class CLI < Thor
    DEFAULT_FORMAT = 'json'

    def initialize(*args)
      super
      @database = Keg::Database.new(ENV["HOME"])
    end

    desc "switch DB_NAME", "switching Database to DB_NAME."
    def switch(db_name)
      if @database.switch(db_name)
        puts "switch DataBase '#{db_name}'"
      else
        puts "No such directroy '#{db_name}'"
      end
    end

    desc "show filename", "output file contents that was formatted in TOML."
    method_option "format", desc: "json, yaml", default: DEFAULT_FORMAT
    def show(filename)
      return if db_does_not_set?

      unless contents = @database.contents(filename)
        puts "No such file '#{filename}'"
        return
      end

      format = Keg::Formatter.instance_of(options["format"])
      
      puts format.format(contents) 
    end

    desc "current", "show current Database name."
    def current
      return if db_does_not_set?

      puts @database.current
    end

    desc "show_all", "output all file contents that was formatted in TOML."
    method_option "format", desc: "json, yaml", default: DEFAULT_FORMAT
    def show_all
      return if db_does_not_set?

      format = Keg::Formatter.instance_of(options["format"])

      @database.each do |contents|
        puts format.format(contents)
      end
    end

    private

    def db_does_not_set?
      db = @database.current
      if db.nil? || db.empty?
        puts 'DB does not set'
        return true
      end
    end
  end
end