require 'keg'

module Keg
  class Formatter
    def self.create(format)
      begin
        formatter = const_get(format.capitalize)
      rescue
        raise "Error: Unavailable format `#{format}`. Please enter a available format."
      end
      formatter.new
    end
  end
end
