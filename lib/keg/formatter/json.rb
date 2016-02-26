require 'keg'
require 'json'

module Keg
  class Formatter
    class Json
      def format(obj)
        obj.to_json
      end
    end
  end
end