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
      @database.switch(db_name)
      puts "switch DataBase `#{db_name}`."
    end

    desc "show filename", "output file contents."
    method_option "format", desc: "json, yaml", default: DEFAULT_FORMAT
    def show(filename)
      contents = @database.contents(filename)
      
      formatter = Formatter.create(options[:format])
      
      puts formatter.format(contents) 
    end

    desc "current", "show current database name."
    def current
      puts @database.current
    end

    desc "show_all", "output all file contents."
    method_option "format", desc: "json, yaml", default: DEFAULT_FORMAT
    def show_all
      formatter = Formatter.create(options[:format])

      @database.each do |contents|
        puts formatter.format(contents)
      end
    end
  end
end