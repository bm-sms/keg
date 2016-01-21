require 'ygl'
require 'toml'

module YGL
  module Database
    def self.switch(db_name)
      path = File.join(home_path, db_name)
      if File.exists?(path)
        YGL::Config.save_db_name(db_name)
      else
        raise IOError, "No such file or directory '#{db_name}'"
      end
    end

    def self.get_toml(filename)
      path = File.join(strong_path, filename+'.toml')
      begin
        TOML.load_file(path)
      rescue
        raise IOError, "No such file or directory '#{filename}'"
      end
    end

    def self.current
      db_name = YGL::Config.load_db_name
      if db_name.empty?
        raise ArgumentError, 'DB dose not set'
      end

      db_name
    end

    def self.each
      Dir.glob(File.join(strong_path, '**', '*.toml')) do |path|
        yield TOML.load_file(path)
      end
    end

    private

    def self.strong_path
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