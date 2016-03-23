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
        abort "Error: No such directroy `#{name}`. Please enter a correct DB name."
      end

      @configuration.save name
    end

    def show(filename)
      @db.use current
      content = @db.select(filename)
    end

    def current
      @configuration.load
    end

    def show_all
      @db.use current
      contents = @db.select_all
    end
  end
end
