require_relative 'test_helper'

class FormatterTest < Minitest::Test
  def test_format_json
    assert_instance_of Keg::Formatter::Json, Keg::Formatter.create('json')
  end

  def test_format_yaml
    assert_instance_of Keg::Formatter::Yaml, Keg::Formatter.create('yaml')
  end
end