require_relative 'test_helper'

class FormatterTest < Minitest::Test
  def setup
    @formatter = YGL::Formatter
  end

  def test_submodules
    assert_equal YGL::Formatter::JSON, @formatter.format('json')
  end
end