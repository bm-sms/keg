require 'ygl'
require 'yaml'

module YGL
  module Formatter
    module YAML
      def formatter(obj)
        obj.to_yaml
      end
    end
  end
end