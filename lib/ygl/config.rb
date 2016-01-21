require 'ygl'

module YGL
  module Config
    def self.save_db_name(name)
      File.write(path, name)
    end

    def self.load_db_name
      begin
        File.open(path, &:read)
      rescue Errno::ENOENT 
        unless Dir.exists?(File.join(@home, 'config'))
          Dir.mkdir(File.join(@home, 'config'))
        end
        save_db_name('')
        retry
      end
    end

    private

    def self.path
      set_home if @home == nil
      File.join(@home, 'config', 'config.txt')
    end

    def self.set_home
      @home = File.join(ENV["HOME"], '.yet_another_glean')
    end
  end
end