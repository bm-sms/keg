require 'ygl'

module YGL
  module Formatter
    def self.format(format)
      submodules.find do |submodule|
        format.downcase == submodule.to_s.downcase
      end
    end

    def self.submodules
      constants.select do |const_name| 
        const_get(const_name).class == Module
      end
    end
  end
end