require 'keg'
require 'thor'

module Keg
  class CLI < Thor
    DEFAULT_FORMAT = 'json'

    def initialize(*args)
      super
      @database = Database.new(ENV["HOME"])
    end

    desc "switch DB_NAME", "Database switch to DB_NAME."
    def switch(name)
      @database.switch name
      puts "switch DataBase `#{name}`."
    end

    desc "show FILE", "output contents from FILE formatted by json or yaml."
    method_option "format", desc: "json, yaml", default: DEFAULT_FORMAT
    def show(filename)
      contents = @database.select(filename)
      formatter = Formatter.create(options[:format])

      puts formatter.format(contents)
    end

    desc "current", "show a current database."
    def current
      puts @database.current
    end

    desc "show_all", "output all contents from current database."
    method_option "format", desc: "json, yaml", default: DEFAULT_FORMAT
    def show_all
      formatter = Formatter.create(options[:format])

      @database.select_all.each do |contents|
        puts formatter.format(contents)
      end
    end
  end
end
