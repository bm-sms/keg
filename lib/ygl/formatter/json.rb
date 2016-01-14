require 'ygl'
require 'json'

module YGL
  module Formatter
    module JSON
      def format(obj)
        obj.to_json
      end
    end
  end
end