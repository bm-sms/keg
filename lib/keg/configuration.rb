require 'keg'

module Keg
  module Configuration
    def self.save_db_name(name)
      File.write(path, name)
    end

    def self.load_db_name
      begin
        File.read(path)
      rescue Errno::ENOENT
        recover_form_open_error
        retry
      end
    end

    private

    def self.path
      File.join(root_path, 'config')
    end

    def self.root_path
      File.join(ENV["HOME"], '.keg')
    end

    def self.recover_form_open_error
      unless Dir.exists?(root_path)
        Dir.mkdir(root_path)
      end
      save_db_name('')
    end
  end
end