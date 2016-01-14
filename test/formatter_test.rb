require_relative 'test_helper'

class FormatterTest < Minitest::Test
  def setup
    @formatter = YGL::Formatter
  end

  def test_submodules
    assert_equal [:JSON, :YAML], @formatter.submodules
  end

  def test_format
    assert_equal :JSON, @formatter.format('json')
  end
end