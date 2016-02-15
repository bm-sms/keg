require 'keg'
require 'yaml'

module Keg
  module Formatter
    module Yaml
      def self.format(obj)
        obj.to_yaml
      end

      def self.parse(str)
        YAML.load(str)
      end
    end
  end
end