require 'keg'
require 'yaml'

module Keg
  class Formatter
    class Yaml
      def format(obj)
        obj.to_yaml
      end
    end
  end
end