require_relative 'test_helper'

class FormatterTest < Minitest::Test
  def setup
    @formatter = Keg::Formatter.new
  end

  def test_format_json
    assert_equal Keg::Formatter::Json.new, @formatter.formatter('json')
  end

  def test_format_yaml
    assert_equal Keg::Formatter::Yaml.new, @formatter.formatter('yaml')
  end

  def test_format_faild
    assert_equal nil, @formatter.formatter('aaa')
  end
end