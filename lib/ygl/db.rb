require 'ygl'

module Ygl
  HOME_PATH = "#{ENV["HOME"]}/.yet_another_glean"

  module DB
    def self.switch(name)
      @path = "#{HOME_PATH}/#{name}"
      Ygl::Conf.save_db_name(name) if File.exists?(@path)
    end

    def self.get_file(filename)
      begin
        File.open("#{HOME_PATH}/#{current}/#{filename}.toml", 'r')
      rescue
        false
      end
    end

    def self.current
      Ygl::Conf.load_db_name
    end
  end
end