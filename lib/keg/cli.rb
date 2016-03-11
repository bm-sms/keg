require 'keg'
require 'thor'

module Keg
  class CLI < Thor
    DEFAULT_FORMAT = 'json'

    def initialize(*args)
      super
      @interface = Interface.new(ENV["HOME"])
    end

    desc "switch DB_NAME", "switching database to DB_NAME."
    def switch(db_name)
      @interface.switch(db_name)
      puts "switch DataBase `#{db_name}`."
    end

    desc "show filename", "output file contents."
    method_option "format", desc: "json, yaml", default: DEFAULT_FORMAT
    def show(filename)
      puts @interface.show(filename, options[:format])
    end

    desc "current", "show current database name."
    def current
      puts @interface.current
    end

    desc "show_all", "output all file contents."
    method_option "format", desc: "json, yaml", default: DEFAULT_FORMAT
    def show_all
      @interface.each(options[:format]) do |contents| 
        puts contents
      end
    end
  end
end