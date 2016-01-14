require_relative 'test_helper'

class FormatterTest < Minitest::Test
  def setup
    @formatter = YGL::Formatter
  end

  def test_submodules
    assert_equal [@formatter::JSON, @formatter::YAML], @formatter.submodules
  end

  def test_format_json
    assert_equal @formatter::JSON, @formatter.format('json')
  end

  def test_format_yaml
    assert_equal @formatter::YAML, @formatter.format('yaml')
  end

  def test_format_faild
    assert_equal nil, @formatter.format('aaa')
  end
end