require 'ygl'
require 'toml'

module Ygl
  HOME_PATH = "#{ENV["HOME"]}/.yet_another_glean"

  module DB
    def self.switch(name)
      path = File.join(HOME_PATH, name)
      Ygl::Conf.save_db_name(name) if File.exists?(path)
    end

    def self.get_toml(filename)
      path = File.join(HOME_PATH, current, filename+'.toml')
      TOML.load_file(path)
      rescue raise
    end

    def self.current
      Ygl::Conf.load_db_name
    end
  end
end