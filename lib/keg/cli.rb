require 'keg'
require 'thor'

module Keg
  class CLI < Thor
    DEFAULT_FORMAT = 'json'

    def initialize(*args)
      super
      @db_manager = DBManager.new(ENV["HOME"])
    end

    desc "switch DB_NAME", "Database switch to DB_NAME."
    def switch(name)
      @db_manager.switch name
      puts "switch DataBase `#{name}`."
    end

    desc "show FILE", "output contents from FILE formatted by json or yaml."
    method_option "format", desc: "json, yaml", default: DEFAULT_FORMAT
    def show(filename)
      contents = @db_manager.show(filename)
      formatter = Formatter.create(options[:format])

      puts formatter.format(contents)
    end

    desc "current", "show a current database."
    def current
      puts @db_manager.current
    end

    desc "show_all", "output all contents from current database."
    method_option "format", desc: "json, yaml", default: DEFAULT_FORMAT
    def show_all
      formatter = Formatter.create(options[:format])

      @db_manager.show_all.each do |contents|
        puts formatter.format(contents)
      end
    end
  end
end
