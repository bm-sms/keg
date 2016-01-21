require 'ygl'
require 'json'

module YGL
  module Formatter
    module Json
      def self.format(obj)
        obj.to_json
      end
    end
  end
end