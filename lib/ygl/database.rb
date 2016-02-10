require 'ygl'
require 'toml'

module YGL
  module Database
    def self.switch(db_name)
      path = File.join(home_path, db_name)
      if File.directory?(path)
        YGL::Configuration.save_db_name(db_name)
      end
    end

    def self.contents(filename)
      path = File.join(db_path, filename+'.toml')
      if File.exists?(path)
        TOML.load_file(path)
      end
    end

    def self.current
      YGL::Configuration.load_db_name
    end

    def self.each
      Dir.glob("#{db_path}/**/*.toml") do |path|
          yield TOML.load_file(path)
      end
    end

    private

    def self.db_path
      File.join(home_path, current)
    end

    def self.home_path
      File.join(ENV["HOME"], '.yet_another_glean')
    end
  end
end