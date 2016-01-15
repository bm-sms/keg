require 'ygl'
require 'thor'

module YGL
  class CLI < Thor
    desc "switch DB_NAME", "switching DB to DB_NAME"
    def switch(db_name)
      YGL::DB.switch(db_name)
      puts "switch DataBase '#{db_name}'"
    end

    desc "show filename", "output toml file"
    method_option "format", desc: "json, yaml", default: 'json'
    def show(filename)
      toml = YGL::DB.get_toml(filename)
      formatter =  YGL::Formatter.formatter(options["format"])
      puts formatter.format(toml) 
    end

    desc "current", "show current DB name"
    def current
      puts YGL::DB.current
    end

    desc "show_all filename", "output all toml file"
    method_option "format", desc: "json, yaml", default: 'json'
    def show_all
      formatter =  YGL::Formatter.formatter(options["format"])
      YGL::DB.each do |toml|
        puts formatter.format(toml)
      end
    end
  end
end