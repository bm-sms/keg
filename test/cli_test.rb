require_relative 'test_helper'
require 'yaml'

class YglCLITest < Minitest::Test
  def setup
    @cli = YGL::CLI.new
    YGL::Database.switch('daimon-lunch')
    @oosaka = {"name" => "東麻布 逢坂",
               "url"  => "http://tabelog.com/tokyo/A1314/A131401/13044558/"}
    @ranma  = {"name" => "蘭麻",
               "url"  =>"http://tabelog.com/tokyo/A1314/A131401/13034212/"}   
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

  def test_show_no_such_file
    assert_raises(IOError) { @cli.show('aaa') }
  end

  def test_show_does_not_select_db
    File.write('config/config.txt', '')
    assert_raises(ArgumentError) { @cli.show('oosaka') }
  end

  def test_current_success
    out, err = capture_io { @cli.current }
    assert_equal "daimon-lunch\n", out
  end

  def test_current_does_not_select_db
    File.write('config/config.txt', '')
    assert_raises(ArgumentError) { @cli.current }
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

  def test_show_all_empty
    @cli.switch("empty")
    out, err = capture_io { @cli.invoke(:show_all) }
    assert_equal '', out
  end
end