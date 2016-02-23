require 'keg'
require 'json'

module Keg
  module Formatter
    class Json
      def format(obj)
        obj.to_json
      end
    end
  end
end