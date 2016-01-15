require 'ygl'
require 'toml'

module YGL
  module DB
    HOME_PATH = "#{ENV["HOME"]}/.yet_another_glean"
    
    def self.switch(db_name)
      path = File.join(HOME_PATH, db_name)
      if File.exists?(path)
        save_db_name(db_name)
      else
        raise IOError, "No such file or directory '#{db_name}'"
      end
    end

    def self.get_toml(filename)
      path = File.join(strong_path, filename+'.toml')
      TOML.load_file(path)
    end

    def self.current
      db_name = load_db_name
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
      File.join(HOME_PATH, current)
    end

    def self.save_db_name(name)
      File.write('config/config.txt', name)
    end

    def self.load_db_name
      File.open('config/config.txt', &:read)
    end
  end
end