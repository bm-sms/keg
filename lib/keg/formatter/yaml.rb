require 'keg'
require 'yaml'

module Keg
  module Formatter
    module Yaml
      def self.format(obj)
        obj.to_yaml
      end
    end
  end
end