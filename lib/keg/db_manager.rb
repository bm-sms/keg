require 'keg'

module Keg
  class DBManager
    def initialize(root)
      @db = Database.new(root)
      @configuration.new(root)
    end

    def switch(name)
      path = File.join(@db.databases_path, name)
      if !Dir.exist?(path) || name.empty?
        abort "Error: No such directroy `#{name}`. Please enter a correct DB name."
      end

      @configuration.save name
    end

    def show(filename)
      database = @configuration.load
      @db.use database
      content = @db.select(filename)
    end

    def current
      name = @configuration.load
      if db_doe_set?
        return name
      else
        abort "Error: DB does not set. Make sure that `keg switch DB_NAME`."
      end
    end

    def show_all
      database = @configuration.load
      @db.use database
      contents = @db.select_all
    end

    def db_doe_set?
      name = @configuration.load
      unless name.nil? || name.empty?
        return true
      else
        return false
      end
    end
  end
end
