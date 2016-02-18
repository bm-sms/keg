require 'keg'

module Keg
  class Formatter
    def formatter(format)
      submodules.find do |submodule|
        format.downcase == last_module_name(submodule)
      end
    end

    def available_format?(format)
      self.class.const_define?(format)
    end

    private

    def submodules
      consts = self.class.constants.map do |const_name| 
        const = self.class.const_get(const_name)
      end
      consts.select do |const|
        const.class == Class
      end
    end

    def last_module_name(submodule)
      submodule.name.split('::').last.downcase
    end
  end
end