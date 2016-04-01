require 'keg'

module Keg
  class Formatter
    def self.create(format)
      formatter = const_get(format.capitalize)
      formatter.new
    end
  end
end
