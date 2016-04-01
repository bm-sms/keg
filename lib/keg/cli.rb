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
        content = @database.select(filename)
        formatter = Formatter.create(options[:format])
      rescue Errno::ENOENT => e
        raise Thor::InvocationError.new("#{e.message}\nPlease enter a exist file name.")
      end
      if content == false
        raise Thor::InvocationError.new("Current database is unknown directory. Make sure that `keg switch <database>`.")
      end

      puts formatter.format(content)
    end

    desc "current", "show a current database."
    def current
      puts @database.current
    end

    desc "show_all", "output all contents from current database."
    method_option "format", desc: "json, yaml", default: DEFAULT_FORMAT
    def show_all
      formatter = Formatter.create(options[:format])
      unless contents = @database.select_all
        raise Thor::InvocationError.new("Current database is unknown directory. Make sure that `keg switch <database>`.")
      end

      contents.each do |content|
        puts formatter.format(content)
      end
    end
  end
end
