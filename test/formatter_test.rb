require_relative 'test_helper'

class FormatterTest < Minitest::Test
  def test_format_json
    assert_instance_of Keg::Formatter::Json, Keg::Formatter.create('json')
  end

  def test_format_yaml
    assert_instance_of Keg::Formatter::Yaml, Keg::Formatter.create('yaml')
  end

  def test_available_format_unavailable
    assert_equal Keg::Formatter.available_format?('aaaa'), false
  end

  def test_available_format_unexpected_format
    assert_equal Keg::Formatter.available_format?('!@#$'), false
  end

  def test_available_format_blank_format
    assert_equal Keg::Formatter.available_format?(''), false
  end
end