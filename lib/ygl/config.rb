require 'ygl'

module YGL
  module Config
    def self.save_db_name(name)
      File.write('config/config.txt', name)
    end

    def self.load_db_name
      File.open('config/config.txt', &:read)
    end
  end
end