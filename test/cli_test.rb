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
    out, err = capture_io { @cli.switch("aaa") }
    assert_equal "No such directroy 'aaa'\n", out
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
    out, err = capture_io { @cli.invoke(:show, ['oosaka'], { format: 'aaa'} ) }
    assert_equal @oosaka.to_json + "\n", out
  end

  def test_show_no_such_file
    out, err = capture_io { @cli.show('aaa') }
    assert_equal "No such file 'aaa'\n", out
  end

  def test_show_does_not_select_db
    YGL::Configuration.save_db_name('')
    out, err = capture_io { @cli.show('oosaka') }
    assert_equal "No such file 'oosaka'\n", out
  end

  def test_current_success
    out, err = capture_io { @cli.current }
    assert_equal "daimon-lunch\n", out
  end

  def test_current_does_not_select_db
    YGL::Configuration.save_db_name('')
    out, err = capture_io { @cli.current }
    assert_equal "DB does not set\n", out
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
    out, err = capture_io { @cli.invoke(:show_all, [], { format: 'aaa' }) }
    assert_equal @oosaka.to_json + "\n" +
                 @ranma.to_json  + "\n", out
  end

  def test_show_all_empty
    YGL::Configuration.save_db_name("empty")
    out, err = capture_io { @cli.show_all }
    assert_equal '', out
  end

  def test_show_all_db_does_not_set
    YGL::Configuration.save_db_name('')
    out, err = capture_io { @cli.show_all }
    assert_equal @oosaka.to_json + "\n" +
                 @ranma.to_json  + "\n", out
  end
end