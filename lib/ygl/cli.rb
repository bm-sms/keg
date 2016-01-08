require 'ygl'
require 'thor'
require 'json'
require 'yaml'

module Ygl
  class CLI < Thor
    desc "switch DB_NAME", "switching DB to DB_NAME"
    def switch(name)
      if Ygl::DB.switch(name)
        puts "switch DataBase '#{name}'"
      else
        raise "Error: No such directory '#{name}'"
      end
    end

    desc "show --format=(yaml, json) filename", "print file"
    option "format", default: "json"    
    def show(filename)
      toml = Ygl::DB.get_toml(filename)
      case options["format"]
      when "json" then puts toml.to_json
      when "yaml" then puts toml.to_yaml  
      else raise "Unknow format '#{options["format"]}'"
      end
    end

    desc "current", "show current DB name"
    def current
      puts Ygl::DB.current
    end
  end
end