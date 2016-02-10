require 'ygl'
require 'yaml'

module YGL
  module Formatter
    module Yaml
      def self.format(obj)
        obj.to_yaml
      end
    end
  end
end