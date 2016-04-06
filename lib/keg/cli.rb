require 'keg'
require 'thor'

module Keg
  class CLI < Thor
    DEFAULT_FORMAT = 'json'
    def self.exit_on_failure?; true end

    def initialize(*args)
      super
      @database = Database.new(ENV["HOME"])
    end

    desc "switch <database>", "Database switch to <database>."
    def switch(name)
      begin
        @database.switch name
      rescue => e
        raise Thor::InvocationError.new(e)
      end
      puts "switch DataBase `#{name}`."
    end

    desc "show <file>", "output contents from <file> formatted by json or yaml."
    method_option "format", desc: "json, yaml", default: DEFAULT_FORMAT
    def show(filename)
      begin
        content = @database.select(filename)
        formatter = Formatter.create(options[:format])
      rescue => e
        raise Thor::InvocationError.new(e)
      end

      puts formatter.format(content)
    end

    desc "current", "show a current database."
    def current
      begin
        puts @database.current
      rescue => e
        raise Thor::InvocationError.new(e.message)
      end
    end

    desc "show_all", "output all contents from current database."
    method_option "format", desc: "json, yaml", default: DEFAULT_FORMAT
    def show_all
      begin
        contents = @database.select_all
        formatter = Formatter.create(options[:format])
      rescue => e
        raise Thor::InvocationError.new(e)
      end

      contents.each do |content|
        puts formatter.format(content)
      end
    end
  end
end
