require 'ygl'

module YGL
  module Formatter
    def self.format(format)
      submodules.find do |submodule|
        format.downcase == module_name(submodule)
      end
    end

    private

    def self.submodules
      consts = constants.collect do |const_name|
        const_get(const_name)
      end
      consts.select do |const|
        const.class == Module
      end
    end
    def self.module_name(submodule)
      submodule.name.split('::').last.downcase
    end
  end
end