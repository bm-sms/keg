require 'ygl'
require 'thor'

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

    desc "show --format={yaml or json} filename", "print file"
    def show(filename)
      file = Ygl::DB.get_file(filename)
      file.each {|line| puts line.to_json }
      file.close
    end

    desc "current", "show current DB name"
    def current
      puts Ygl::DB.current
    end
  end
end