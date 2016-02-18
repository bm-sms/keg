require_relative 'test_helper'

class FormatterTest < Minitest::Test
  def test_format_json
    formatter = Keg::Formatter.new('json')
    assert_equal formatter.formatter.instance_of?(Keg::Formatter::Json), true
  end

  def test_format_yaml
    formatter = Keg::Formatter.new('yaml')
    assert_equal formatter.formatter.instance_of?(Keg::Formatter::Yaml), true
  end

  def test_format_unavailable
    formatter = Keg::Formatter.new('aaaa')
    assert_equal formatter.formatter.instance_of?(Keg::Formatter::Json), true
  end
end