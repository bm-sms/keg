require 'keg'

module Keg
  class Formatter
    def self.create(format)
      format = 'json' unless available?(format)

      formatter = const_get(format.capitalize)
      formatter.new
    end

    private

    def self.available?(format)
      const_defined?(format.upcase) if alphabet?(format)
    end

    def self.alphabet?(format)
      /[a-zA-Z]/ === format
    end
  end
end