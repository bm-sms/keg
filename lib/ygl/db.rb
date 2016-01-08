require 'ygl'
require 'toml'

module YGL
  HOME_PATH = "#{ENV["HOME"]}/.yet_another_glean"

  module DB
    def self.switch(name)
      path = File.join(HOME_PATH, name)
      YGL::Conf.save_db_name(name) if File.exists?(path)
    end

    def self.get_toml(filename)
      path = File.join(strong_path, filename+'.toml')
      TOML.load_file(path)
      rescue raise
    end

    def self.current
      YGL::Conf.load_db_name
    end

    def self.get_toml_all
      Dir.glob(File.join(strong_path, '**', '*.toml'))
    end

    private

    def self.strong_path
      File.join(HOME_PATH, current)
    end
  end
end