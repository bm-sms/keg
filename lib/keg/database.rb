require 'keg'
require 'toml'

module Keg
  class Database
    def initialize(root)
      @root = root
      @configuration = Configuration.new(root)
    end

    def switch(name)
      path = File.join(databases_path, name)
      if !Dir.exists?(path) || name.empty?
        raise Errno::ENOENT
      end

      @configuration.save name
    end

    def select(filename)
      path = File.join(current_path, filename+'.toml')
      TOML.load_file(path)
    end

    def current
      name = @configuration.load
      path = File.join(databases_path, name)
      if Dir.exist?(path)
        return name
      else
        abort "Error: Current database is unknown directory `#{name}`. Please set a exist database."
      end
    end

    def select_all
      Dir.glob("#{current_path}/**/*.toml").map do |path|
          TOML.load_file(path)
      end
    end

    def current_path
      File.join(databases_path, current)
    end

    def databases_path
      File.join(@root, '.keg', 'databases')
    end
  end
end
