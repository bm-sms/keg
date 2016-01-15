require_relative 'test_helper'

class FormatterTest < Minitest::Test
  def setup
    @formatter = YGL::Formatter
  end

  def test_format_json
    assert_equal @formatter::JSON, @formatter.formatter('json')
  end

  def test_format_yaml
    assert_equal @formatter::YAML, @formatter.formatter('yaml')
  end

  def test_format_faild
    assert_raises(ArgumentError) { @formatter.formatter('aaa') }
  end
end