require_relative 'test_helper'

class FormatterTest < Minitest::Test
  def setup
    @formatter = Keg::Formatter.new
  end

  def test_format_json
    assert_equal @formatter.formatter('json').instance_of?(Keg::Formatter::Json), true
  end

  def test_format_yaml
    assert_equal @formatter.formatter('yaml').instance_of?(Keg::Formatter::Yaml), true
  end

  def test_available_format_json
    assert_equal @formatter.available_format?('json'), true
  end

  def test_available_format_yaml
    assert_equal @formatter.available_format?('yaml'), true
  end

  def test_available_format_none
    assert_equal @formatter.available_format?('aaaa'), false
  end
end