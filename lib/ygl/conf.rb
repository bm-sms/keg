require 'ygl'

module Ygl
  module Conf
    def self.save_db_name(name)
      if File.write('config/config.txt', name)
        return true
      else
        return false
      end
    end

    def self.load_db_name
      File.open('config/config.txt', &:read)
    end
  end
end