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

    desc "show filename", "print file by format"
    method_option "format", desc: "json, yaml", default: 'json'
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
      db_name = YGL::DB.current
      raise 'DB dose not set' if db_name == ''

      puts db_name
    end

    desc "show_all filename", "print all toml file"
    method_option "format", desc: "json, yaml", default: 'json'
    def show_all
      YGL::DB.each do |toml|
        case options["format"]
        when "json" then puts toml.to_json
        when "yaml" then puts toml.to_yaml
        else raise "Unknow format '#{options["format"]}'"
        end
      end
    end
  end
end