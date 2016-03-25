require 'keg'

module Keg
  class DBManager
    def initialize(root)
      @db = Database.new(root)
      @configuration = Configuration.new(root)
    end

    def switch(name)
      path = File.join(@db.databases_path, name)
      if !Dir.exist?(path) || name.empty?
        abort "Error: No such directroy `#{name}`. Please enter a exist database name."
      end

      @configuration.save name
    end

    def show(filename)
      @db.use current
      @db.select filename
    end

    def current
      name = @configuration.load
      path = File.join(@db.databases_path, name)
      if Dir.exist?(path)
        return name
      else
        abort "Error: Current database is unknown directroy `#{name}`."
      end
    end

    def show_all
      @db.use current
      @db.select_all
    end
  end
end
