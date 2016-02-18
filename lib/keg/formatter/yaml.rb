require 'keg'
require 'yaml'

module Keg
  class Formatter
    class Yaml
      def format(obj)
        obj.to_yaml
      end

      def self.parse(str)
        YAML.load(str)
      end
    end
  end
end