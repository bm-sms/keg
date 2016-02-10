require 'keg'
require 'json'

module Keg
  module Formatter
    module Json
      def self.format(obj)
        obj.to_json
      end
    end
  end
end