require 'ygl'
require 'thor'
require 'json'

module Ygl
  class CLI < Thor
    desc "switch DB_NAME", "switching DB to DB_NAME"
    def switch(name)
      if Ygl::DB.switch(name)
        puts "switch DataBase '#{name}'"
      else
        puts "No such directory '#{name}'"
      end
    end

    desc "show --format=(yaml, json) filename", "print file"
    def show(filename)
      toml = Ygl::DB.get_toml(filename)
      puts toml.to_json
    end

    desc "current", "show current DB name"
    def current
      puts Ygl::DB.current
    end
  end
end