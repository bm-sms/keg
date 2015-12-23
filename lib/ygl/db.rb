require 'ygl'

module Ygl
  module DB
    def self.switch(name)
      @path = "#{ENV["HOME"]}/.yet_another_glean/#{name}"
      Ygl::Conf.save_db_name(name) if File.exists?(@path)
    end

    def self.get_file(filename)
      begin
        @db = File.open("#{@path}/#{filename}.toml")
      rescue
        false
      end
    end

    def self.close
      @db.close
    end

    def self.current
      Ygl::Conf.load_db_name
    end
  end
end