require_relative 'test_helper'
require 'yaml'

class YglCLITest < Minitest::Test
  def setup
    @cli = YGL::CLI.new
    YGL::DB.switch('daimon-lunch')
    @oosaka = YGL::DB.get_toml('oosaka')
    @ranma  = YGL::DB.get_toml('ranma')
  end

  def test_switch_success
    out, err = capture_io { @cli.switch("daimon-lunch") }
    assert_equal %Q(switch DataBase 'daimon-lunch'\n), out
  end

  def test_switch_faild
    assert_raises(IOError) { @cli.switch("aaa") }
  end

  def test_show_defalut
    out, err = capture_io { @cli.invoke(:show, ['oosaka']) }
    assert_equal @oosaka.to_json + "\n", out
  end

  def test_show_json
    out, err = capture_io { @cli.invoke(:show, ['oosaka'], { format: 'json'}) }
    assert_equal @oosaka.to_json + "\n", out
  end

  def test_show_yaml
    out, err = capture_io { @cli.invoke(:show, ['oosaka'], { format: 'yaml' }) }
    assert_equal @oosaka.to_yaml, out
  end

  def test_show_unkwon_format
    assert_raises(ArgumentError) { @cli.invoke(:show, ['oosaka'], { format: 'aaa'} ) }
  end

  def test_current_success
    out, err = capture_io { @cli.current }
    assert_equal "daimon-lunch\n", out
  end

  def test_show_all_defalut
    out, err = capture_io { @cli.invoke(:show_all) }
    assert_equal @oosaka.to_json + "\n" + 
                 @ranma.to_json  + "\n", out
  end

  def test_show_all_json
    out, err = capture_io { @cli.invoke(:show_all, [], { format: 'json' }) }
    assert_equal @oosaka.to_json + "\n" +
                 @ranma.to_json  + "\n", out
  end

  def test_show_all_yaml
    out, err = capture_io { @cli.invoke(:show_all, [], { format: 'yaml'}) }
    assert_equal @oosaka.to_yaml + @ranma.to_yaml, out
  end

  def test_show_all_unkwon_format
    assert_raises(ArgumentError) { @cli.invoke(:show_all, [], { format: 'aaa' }) }
  end
end