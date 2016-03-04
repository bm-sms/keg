require 'keg'
require 'thor'

module Keg
  class CLI < Thor
    DEFAULT_FORMAT = 'json'

    def initialize(*args)
      super
      @database = Database.new(ENV["HOME"])
      @validator = Validator.new(@database)
    end

    def self.exit_on_failure?
      true
    end

    desc "switch <database_name>", "switching database that you are selected."
    def switch(db_name)
      @validator.check_dir(db_name)

      @database.switch(db_name)
      puts "switch database `#{db_name}`."
    end

    desc "show <filename>", "output file contents in current database."
    method_option :format, desc: "json, yaml", default: DEFAULT_FORMAT
    def show(filename)
      @validator.check_database 
      @validator.check_format(options[:format])
      @validator.check_file(filename)

      contents = @database.contents(filename)
      formatter = Formatter.create(options["format"])
      puts formatter.format(contents) 
    end

    desc "current", "output current database name."
    def current
      @validator.check_database

      puts @database.current
    end

    desc "show_all", "output all file contents in current database."
    method_option :format, desc: "json, yaml", default: DEFAULT_FORMAT
    def show_all
      @validator.check_database
      @validator.check_format(options["format"])

      formatter = Formatter.create(options[:format])

      @database.each do |contents|
        puts formatter.format(contents)
      end
    end
  end
end