require 'keg'
require 'thor'

module Keg
  class CLI < Thor
    DEFAULT_FORMAT = 'json'

    def initialize(*arg)
      super
      @database = Keg::Database.new(ENV["HOME"])
    end

    desc "switch DB_NAME", "switching Database to DB_NAME"
    def switch(db_name)
      if @database.switch(db_name)
        puts "switch DataBase '#{db_name}'"
      else
        puts "No such directroy '#{db_name}'"
      end
    end

    desc "show filename", "output toml file"
    method_option "format", desc: "json, yaml", default: DEFAULT_FORMAT
    def show(filename)
      if @database.current.nil?
        puts "DB does not set"
        return
      end

      unless contents = @database.contents(filename)
        puts "No such file '#{filename}'"
        return
      end

      formatter = Keg::Formatter.new(options["format"])
      format = formatter.formatter
      
      puts format.format(contents) 
    end

    desc "current", "show current Database name"
    def current
      db_name = @database.current
      if db_name.nil? || db_name.empty? 
        puts 'DB does not set'
        return
      end

      puts db_name
    end

    desc "show_all filename", "output all toml file"
    method_option "format", desc: "json, yaml", default: DEFAULT_FORMAT
    def show_all
      if @database.current.nil?
        puts 'DB does not set'
        return
      end

      formatter = Keg::Formatter.new(options["format"])
      format = formatter.formatter

      @database.each do |contents|
        puts format.format(contents)
      end
    end
  end
end