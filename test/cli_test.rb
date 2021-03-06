require_relative 'test_helper'

class CLITest < Minitest::Test
  def setup
    @cli = Keg::CLI.new
    @root = ENV["HOME"]
    @core = Keg::Core.new(@root)
    @core.switch('glean-daimon-lunch')
    @configuration = Keg::Configuration.new(@root)
    @oosaka = {"name" => "東麻布 逢坂",
               "url"  => "http://tabelog.com/tokyo/A1314/A131401/13044558/"}
    @ranma  = {"name" => "蘭麻",
               "url"  =>"http://tabelog.com/tokyo/A1314/A131401/13034212/"}
  end

  def test_switch_success
    out, err = capture_io { @cli.invoke(:switch, ['glean-daimon-lunch']) }
    assert_equal "Switch dataBase `glean-daimon-lunch`.\n", out
  end

  def test_switch_faild
    msg = "Error: No such directory `aaa`. Please enter a exist database."
    exception = assert_raises(Thor::InvocationError) { @cli.invoke(:switch, ["aaa"]) }
    assert_equal msg, exception.message
  end

  def test_switch_blank
    msg = "Error: No such directory ``. Please enter a exist database."
    exception = assert_raises(Thor::InvocationError) { @cli.invoke(:switch, [""]) }
    assert_equal msg, exception.message
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
    msg =  "Error: Unavailable format `aaa`. Please enter a available format `JSON` or `YAML`."
    exception = assert_raises(Thor::InvocationError) { @cli.invoke(:show, ['oosaka'], { format: 'aaa'} ) }
    assert_equal msg, exception.message
  end

  def test_show_unexpected_format
    msg =  "Error: Unavailable format `!@\#$`. Please enter a available format `JSON` or `YAML`."
    exception = assert_raises(Thor::InvocationError) { @cli.invoke(:show, ['oosaka'], { format: '!@#$'}) }
    assert_equal msg, exception.message
  end

  def test_show_no_such_file
    msg =  "No such file or directory @ rb_sysopen - #{@root}/.keg/databases/glean-daimon-lunch/aaa.toml"
    exception = assert_raises(Thor::InvocationError) { @cli.invoke(:show, ['aaa']) }
    assert_equal msg, exception.message
  end

  def test_show_does_not_select_db
    @configuration.save('')
    msg =  "Error: Database does not set. You should set a database."
    exception = assert_raises(Thor::InvocationError) { @cli.invoke(:show, ['oosaka']) }
    assert_equal msg, exception.message
  end

  def test_show_db_unknown_directory
    @configuration.save 'aaaa'
    msg =  "Current database is unknown directory `aaaa`. Please set a exist database."
    exception = assert_raises(Thor::InvocationError) { @cli.invoke(:show,['oosaka']) }
    assert_equal msg, exception.message
  end

  def test_current_success
    out, err = capture_io { @cli.invoke(:current) }
    assert_equal "glean-daimon-lunch\n", out
  end

  def test_current_db_is_unknown_directory
    @configuration.save 'aaa'
    out, err = capture_io { @cli.invoke(:current) }
    assert_equal "aaa\n", out
  end

  def test_current_does_not_select_db
    @configuration.save ''
    msg =  "Error: Database does not set. You should set a database."
    exception = assert_raises(Thor::InvocationError) { @cli.invoke(:current) }
    assert_equal msg, exception.message
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
    msg =  "Error: Unavailable format `aaa`. Please enter a available format `JSON` or `YAML`."
    exception = assert_raises(Thor::InvocationError) { @cli.invoke(:show_all, [], { format: 'aaa' }) }
    assert_equal msg, exception.message
  end

  def test_show_all_unexpected_format
    msg =  "Error: Unavailable format `!@\#$`. Please enter a available format `JSON` or `YAML`."
    exception = assert_raises(Thor::InvocationError) { @cli.invoke(:show_all, [], { format: '!@#$' }) }
    assert_equal msg, exception.message
  end

  def test_show_all_no_such_directory
    @configuration.save 'aaaa'
    assert_raises(Thor::InvocationError) { @cli.invoke(:show_all) }
  end

  def test_show_all_db_does_not_set
    @configuration.save('')
    msg =  "Error: Database does not set. You should set a database."
    exception = assert_raises(Thor::InvocationError) { @cli.invoke(:show_all) }
    assert_equal msg, exception.message
  end
end
