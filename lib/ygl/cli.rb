require 'ygl'
require 'thor'

module YGL
  class CLI < Thor
    DEFAULT_FORMAT = 'json'

    desc "switch DB_NAME", "switching Database to DB_NAME"
    def switch(db_name)
      begin
        YGL::Database.switch(db_name)
      rescue Errno::ENOENT
        puts "No such directroy '#{db_name}'"
        return
      end

      puts "switch DataBase '#{db_name}'"
    end

    desc "show filename", "output toml file"
    method_option "format", desc: "json, yaml", default: DEFAULT_FORMAT
    def show(filename)
      begin
        toml = YGL::Database.get_toml(filename)
      rescue Errno::ENOENT
        puts "No such file '#{filename}'"
        return
      end

      if YGL::Formatter.available?(options["format"])
        formatter =  YGL::Formatter.formatter(options["format"])
      else
        formatter = YGL::Formatter.formatter(DEFAULT_FORMAT)
      end
      puts formatter.format(toml) 
    end

    desc "current", "show current Database name"
    def current
      db_name = YGL::Database.current
      unless db_name.empty?
        puts db_name
      else
        puts 'DB does not set'
      end
    end

    desc "show_all filename", "output all toml file"
    method_option "format", desc: "json, yaml", default: 'json'
    def show_all
      if YGL::Formatter.available?(options["format"])
        formatter =  YGL::Formatter.formatter(options["format"])
      else
        formatter = YGL::Formatter.formatter(DEFAULT_FORMAT)
      end
      
      YGL::Database.each do |toml|
        puts formatter.format(toml)
      end
    end
  end
end