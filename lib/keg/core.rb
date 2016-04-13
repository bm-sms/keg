require 'keg'
require 'toml'

module Keg
  class Core
    def initialize(root)
      @root = root
      @configuration = Configuration.new(root)
    end

    def switch(name)
      path = File.join(databases_path, name)
      if !Dir.exists?(path) || name.empty?
        raise "Error: No such directory `#{name}`. Please enter a exist database."
      end

      @configuration.save name
    end

    def select(filename)
      unless Dir.exists?(current_path)
        raise "Current database is unknown directory `#{current}`. Please set a exist database."
      end

      path = File.join(current_path, filename+'.toml')
      TOML.load_file(path)
    end

    def current
      @current = @configuration.load if @current.nil?
      @current
    end

    def select_all
      unless Dir.exists?(current_path)
        raise "Current database is unknown directory `#{current}`. Please set a exist database."
      end

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
