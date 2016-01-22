require 'ygl'
require 'toml'

module YGL
  module Database
    def self.switch(db_name)
      path = File.join(home_path, db_name)
      if File.exists?(path)
        YGL::Config.save_db_name(db_name)
      end
    end

    def self.get_toml(filename)
      path = File.join(db_path, filename+'.toml')
      if File.exists?(path)
        TOML.load_file(path)
      end
    end

    def self.current
      YGL::Config.load_db_name
    end

    def self.each
      Dir.glob(File.join(db_path, '**', '*.toml')) do |path|
        yield TOML.load_file(path)
      end
    end

    private

    def self.db_path
      File.join(home_path, current)
    end

    def self.home_path
      set_home if @home == nil
      File.join(@home, '.yet_another_glean')
    end

    def self.set_home
      @home = ENV["HOME"]
    end
  end
end