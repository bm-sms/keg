require 'keg'
require 'thor'

module Keg
  class CLI < Thor
    DEFAULT_FORMAT = 'json'

    def initialize(*args)
      super
      @database = Database.new(ENV["HOME"])
    end

    desc "switch <database>", "Database switch to <database>."
    def switch(name)
      unless @database.switch name
        raise Thor::InvocationError.new("Error: No such directory `#{name}`. Please enter a exist database.")
      end

      puts "switch DataBase `#{name}`."
    end

    desc "show <file>", "output contents from <file> formatted by json or yaml."
    method_option "format", desc: "json, yaml", default: DEFAULT_FORMAT
    def show(filename)
      begin
        contents = @database.select(filename)
        formatter = Formatter.create(options[:format])
      rescue Errno::ENOENT
        raise Thor::InvocationError.new("Error: No such file `#{filename}`. Please enter a correct file name.")
      end

      puts formatter.format(contents)
    end

    desc "current", "show a current database."
    def current
      begin
        name = @database.current
      rescue Errno::ENOENT
        raise Thor::InvocationError.new("Error: Current database is unknown directory `#{name}`. Please set a exist database.")
      end
      puts name
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
