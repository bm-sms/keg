require 'ygl'
require 'thor'
require 'json'
require 'yaml'

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

    desc "show --format=(yaml, json) filename", "print file by format(default = json)"
    option "format", default: "json"    
    def show(filename)
      toml = YGL::DB.get_toml(filename) # return hash
      case options["format"]
      when "json" then puts toml.to_json
      when "yaml" then puts toml.to_yaml  
      else raise "Unknow format '#{options["format"]}'"
      end
    end

    desc "current", "show current DB name"
    def current
      puts YGL::DB.current
    end

    desc "show-all --format=(yaml, json) filename", "print all toml file"
    option "format", default: "json"
    def show_all
      
    end
  end
end