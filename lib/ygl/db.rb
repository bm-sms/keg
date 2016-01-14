require 'ygl'
require 'toml'

module YGL
  HOME_PATH = "#{ENV["HOME"]}/.yet_another_glean"

  module DB
    include Enumerable
    
    def self.switch(name)
      path = File.join(HOME_PATH, name)
      save_db_name(name) if File.exists?(path)
    end

    def self.get_toml(filename)
      path = File.join(strong_path, filename+'.toml')
      TOML.load_file(path)
      rescue raise
    end

    def self.current
      load_db_name
    end

    def self.each
      Dir.glob(File.join(strong_path, '**', '*.toml')) do |path|
        yield TOML.load_file(path)
      end
    end

    private

    def self.strong_path
      File.join(HOME_PATH, current)
    end

    def self.save_db_name(name)
      if File.write('config/config.txt', name)
        return true
      else
        return false
      end
    end

    def self.load_db_name
      begin
        File.open('config/config.txt', &:read)
      rescue
        File.write('config/config.txt', '')
        retry
      end
    end
  end
end