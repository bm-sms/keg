require 'keg'

module Keg
  class Formatter
    def self.create(format)
      formatter = const_get(format.capitalize)
      formatter.new
    end

    def self.available_format?(format)
      return false unless alphabet?(format)
      
      const_defined?(format.upcase)
    end

    private

    def self.alphabet?(format)
      /[a-zA-Z]/ === format
    end
  end
end