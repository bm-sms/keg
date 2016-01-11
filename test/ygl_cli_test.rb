require_relative 'test_helper'
require 'yaml'

class YglCLITest < Minitest::Test
  def setup
    @cli = YGL::CLI.new
    YGL::DB.switch('daimon-lunch')
    @output = YGL::DB.get_toml('oosaka')
  end

  def test_switch_success
    out, err = capture_io { @cli.switch("daimon-lunch") }
    assert_equal %Q(switch DataBase 'daimon-lunch'\n), out
  end

  def test_switch_failure
    # TODO: modify RuntimeError to correct
    assert_raises(RuntimeError) { @cli.switch("aaa") }
  end

  def test_show_defalut
    out, err = capture_io { @cli.invoke(:show, ['oosaka']) }
    assert_equal @output.to_json + "\n", out
  end

  def test_show_json
    out, err = capture_io { @cli.invoke(:show, ['oosaka'], { format: 'json'}) }
    assert_equal @output.to_json + "\n", out
  end

  def test_show_yaml
    out, err = capture_io { @cli.invoke(:show, ['oosaka'], { format: 'yaml' }) }
    assert_equal @output.to_yaml, out
  end

  def test_show_unkwon_format
    # TODO: modify RuntimeError to correct    
    assert_raises(RuntimeError) { @cli.invoke(:show, ['oosaka'], { format: 'aaa'} ) }
  end
end