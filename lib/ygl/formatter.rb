require 'ygl'
require 'json'
require 'yaml'

module YGL
  module Formatter
    def self.to_format(format, hash)
      case format
      when 'json' then hash.to_json
      when 'yaml' then hash.to_yaml
      else raise "Unkwon format '#{format}'"
      end
    end
  end
end