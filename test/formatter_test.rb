require_relative 'test_helper'

class FormatterTest < Minitest::Test
  def test_format_json
    assert_equal Keg::Formatter.create('json').instance_of?(Keg::Formatter::Json), true
  end

  def test_format_yaml
    assert_equal Keg::Formatter.create('yaml').instance_of?(Keg::Formatter::Yaml), true
  end

  def test_format_unavailable
    assert_equal Keg::Formatter.create('aaaa').instance_of?(Keg::Formatter::Json), true
  end

  def test_unexpected_format
    assert_equal Keg::Formatter.create('!@#$').instance_of?(Keg::Formatter::Json), true
  end
end