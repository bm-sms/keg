require 'ygl'
require 'thor'

module YGL
  class CLI < Thor
    desc "switch DB_NAME", "switching DB to DB_NAME"
    def switch(name)
      if YGL::DB.switch(name)
        puts "switch DataBase '#{name}'"
      else
        raise "Error: No such directory '#{name}'"
      end
    end

    desc "show filename", "output toml file"
    method_option "format", desc: "json, yaml", default: 'json'
    def show(filename)
      toml = YGL::DB.get_toml(filename)
      formatter =  YGL::Formatter.format(options["format"])
      raise 'unknown format' if formatter == nil
      puts formatter.format(toml) 
    end

    desc "current", "show current DB name"
    def current
      db_name = YGL::DB.current
      raise 'DB dose not set' if db_name == ''

      puts db_name
    end

    desc "show_all filename", "output all toml file"
    method_option "format", desc: "json, yaml", default: 'json'
    def show_all
      formatter =  YGL::Formatter.format(options["format"])
      raise 'unknown format' if formatter == nil
      YGL::DB.each do |toml|
        puts formatter.format(toml)
      end
    end
  end
end