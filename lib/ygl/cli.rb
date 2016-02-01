require 'ygl'
require 'thor'

module YGL
  class CLI < Thor
    DEFAULT_FORMAT = 'json'

    desc "switch DB_NAME", "switching Database to DB_NAME"
    def switch(db_name)
      if YGL::Database.switch(db_name)
        puts "switch DataBase '#{db_name}'"
      else
        puts "No such directroy '#{db_name}'"
      end
    end

    desc "show filename", "output toml file"
    method_option "format", desc: "json, yaml", default: DEFAULT_FORMAT
    def show(filename)
      unless hash = YGL::Database.contents(filename)
        puts "No such file '#{filename}'"
        return
      end

      if YGL::Formatter.available_format?(options["format"])
        formatter = YGL::Formatter.formatter(options["format"])
      else
        formatter = YGL::Formatter.formatter(DEFAULT_FORMAT)
      end
      puts formatter.format(hash) 
    end

    desc "current", "show current Database name"
    def current
      db_name = YGL::Database.current
      if db_name.empty?
        puts 'DB does not set'
        return
      end

      puts db_name
    end

    desc "show_all filename", "output all toml file"
    method_option "format", desc: "json, yaml", default: DEFAULT_FORMAT
    def show_all
      if YGL::Formatter.available_format?(options["format"])
        formatter = YGL::Formatter.formatter(options["format"])
      else
        formatter = YGL::Formatter.formatter(DEFAULT_FORMAT)
      end

      YGL::Database.each do |hash|
        puts formatter.format(hash)
      end
    end
  end
end