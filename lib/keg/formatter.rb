require 'keg'

module Keg
  class Formatter
    def self.create(format)
      begin
        formatter = const_get(format.capitalize)
      rescue
        abort "Error: Unavailable format `#{format}`. Please enter a available format `json` or `yaml`."
      end
      formatter.new
    end
  end
end