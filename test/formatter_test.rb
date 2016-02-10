require_relative 'test_helper'

class FormatterTest < Minitest::Test
  def setup
    @formatter = Keg::Formatter
  end

  def test_format_json
    assert_equal @formatter::Json, @formatter.formatter('json')
  end

  def test_format_yaml
    assert_equal @formatter::Yaml, @formatter.formatter('yaml')
  end

  def test_format_faild
    assert_equal nil, @formatter.formatter('aaa')
  end
end