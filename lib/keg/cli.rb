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
      if @database.switch name
        puts "switch DataBase `#{name}`."
      else
        raise Thor::InvocationError.new("Error: No such directory `#{name}`. Please enter a exist database.")
      end
    end

    desc "show <file>", "output contents from <file> formatted by json or yaml."
    method_option "format", desc: "json, yaml", default: DEFAULT_FORMAT
    def show(filename)
      begin
        content = @database.select(filename)
        formatter = Formatter.create(options[:format])
      rescue Errno::ENOENT => e
        err_msg = "#{e.message}\nPlease enter a exist file name."
      rescue NameError
        err_msg = "Error: Unavailable format `#{options[:format]}`. Please enter a available format."
      rescue => e
        err_msg = e.message
      else
        unless content
          err_msg = "Current database is unknown directory. Make sure that `keg switch <database>`."
        end
      end
      raise Thor::InvocationError.new(err_msg) if err_msg

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
      rescue NameError
        err_msg = "Error: Unavailable format `#{options[:format]}`. Please enter a available format."
      rescue => e
        err_msg = e.message
      else
        unless contents
          err_msg = "Current database is unknown directory. Make sure that `keg switch <database>`."
        end
      end
      raise Thor::InvocationError.new(err_msg) if err_msg

      contents.each do |content|
        puts formatter.format(content)
      end
    end
  end
end
