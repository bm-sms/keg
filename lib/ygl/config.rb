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
        recovery_open_err
        retry
      end
    end

    private

    def self.path
      set_home if @home == nil
      File.join(@home, 'config')
    end

    def self.set_home
      @home = File.join(ENV["HOME"], '.yet_another_glean')
    end

    def recovery_open_err
      unless Dir.exists?(@home)
        Dir.mkdir(@home)
      end
      save_db_name('')
    end
  end
end