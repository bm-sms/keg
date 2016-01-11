require 'ygl'

module YGL
  module Conf
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