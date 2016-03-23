require 'keg'
require 'thor'

module Keg
  class CLI < Thor
    DEFAULT_FORMAT = 'json'

    def initialize(*args)
      super
      @db_manager = DBManager.new(ENV["HOME"])
    end

    desc "switch DB_NAME", "switching db_manager to DB_NAME."
    def switch(name)
      @db_manager.switch name
      puts "switch DataBase `#{name}`."
    end

    desc "show filename", "output file contents."
    method_option "format", desc: "json, yaml", default: DEFAULT_FORMAT
    def show(filename)
      contents = @db_manager.show(filename)
      formatter = Formatter.create(options[:format])

      puts formatter.format(contents)
    end

    desc "current", "show current db_manager name."
    def current
      puts @db_manager.current
    end

    desc "show_all", "output all file contents."
    method_option "format", desc: "json, yaml", default: DEFAULT_FORMAT
    def show_all
      formatter = Formatter.create(options[:format])

      @db_manager.show_all.each do |contents|
        puts formatter.format(contents)
      end
    end
  end
end
