require_relative 'test_helper'

class FormatterTest < Minitest::Test
  def test_format_json
    assert_equal Keg::Formatter.instance_of('json').instance_of?(Keg::Formatter::Json), true
  end

  def test_format_yaml
    assert_equal Keg::Formatter.instance_of('yaml').instance_of?(Keg::Formatter::Yaml), true
  end

  def test_format_unavailable
    assert_equal Keg::Formatter.instance_of('aaaa').instance_of?(Keg::Formatter::Json), true
  end

  def test_unexpected_format
    assert_equal Keg::Formatter.instance_of('!@#$').instance_of?(Keg::Formatter::Json), true
  end
end