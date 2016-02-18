require 'keg'
require 'thor'

module Keg
  class CLI < Thor
    DEFAULT_FORMAT = 'json'

    desc "switch DB_NAME", "switching Database to DB_NAME"
    def switch(db_name)
      if Keg::Database.switch(db_name)
        puts "switch DataBase '#{db_name}'"
      else
        puts "No such directroy '#{db_name}'"
      end
    end

    desc "show filename", "output toml file"
    method_option "format", desc: "json, yaml", default: DEFAULT_FORMAT
    def show(filename)
      if Keg::Database.current.nil?
        puts "DB does not set"
        return
      end

      unless contents = Keg::Database.contents(filename)
        puts "No such file '#{filename}'"
        return
      end

      if Keg::Formatter.available_format?(options["format"])
        formatter = Keg::Formatter.formatter(options["format"])
      else
        formatter = Keg::Formatter.formatter(DEFAULT_FORMAT)
      end
      puts formatter.format(contents) 
    end

    desc "current", "show current Database name"
    def current
      db_name = Keg::Database.current
      if db_name.nil? || db_name.empty? 
        puts 'DB does not set'
        return
      end

      puts db_name
    end

    desc "show_all filename", "output all toml file"
    method_option "format", desc: "json, yaml", default: DEFAULT_FORMAT
    def show_all
      if Keg::Database.current.nil?
        puts 'DB does not set'
        return
      end

      if Keg::Formatter.available_format?(options["format"])
        formatter = Keg::Formatter.formatter(options["format"])
      else
        formatter = Keg::Formatter.formatter(DEFAULT_FORMAT)
      end

      Keg::Database.each do |contents|
        puts formatter.format(contents)
      end
    end
  end
end