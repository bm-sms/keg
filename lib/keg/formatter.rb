require 'keg'

module Keg
  class Formatter
    def initialize(format)
      @format = format
      @myclass = self.class
    end

    def formatter
      @format = 'json' unless available?

      format = @myclass.const_get(@format.capitalize)
      format.new
    end

    private

    def available?
      @myclass.const_defined?(@format.upcase)
    end
  end
end