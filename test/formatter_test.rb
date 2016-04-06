require_relative 'test_helper'

class FormatterTest < Minitest::Test
  def test_format_json
    assert_instance_of Keg::Formatter::Json, Keg::Formatter.create('json')
  end

  def test_format_yaml
    assert_instance_of Keg::Formatter::Yaml, Keg::Formatter.create('yaml')
  end

  def test_create_faild
    assert_raises(RuntimeError) { Keg::Formatter.create('aaa') }
  end

  def test_create_unavailable_format
    assert_raises(RuntimeError) { Keg::Formatter.create('!"$%') }
  end
end
