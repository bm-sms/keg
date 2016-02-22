require 'keg'

module Keg
  class Formatter
    def initialize(format)
      @format = format
    end

    def self.instance_of(format)
      formatter = new(format)
      format = 'json' unless formatter.available?

      format_class = const_get(format.capitalize)
      format_class.new
    end

    def available?
      self.class.const_defined?(@format.upcase) if alphabet?
    end

    def alphabet?
      /[a-zA-Z]/ === @format
    end
  end
end