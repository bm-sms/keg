require_relative 'test_helper'

class CLITest < Minitest::Test
  def setup
    @cli = Keg::CLI.new
    @database = Keg::Database.new(ENV["HOME"])
    @database.switch('glean-daimon-lunch')
    @config = Keg::Configuration.new(ENV["HOME"])
    @oosaka = {"name" => "東麻布 逢坂",
               "url"  => "http://tabelog.com/tokyo/A1314/A131401/13044558/"}
    @ranma  = {"name" => "蘭麻",
               "url"  =>"http://tabelog.com/tokyo/A1314/A131401/13034212/"}
  end

  def test_switch_success
    out, err = capture_io { @cli.switch("glean-daimon-lunch") }
    assert_equal "switch DataBase `glean-daimon-lunch`.\n", out
  end

  def test_switch_faild
    msg = "Error: No such directroy `aaa`. Please enter a correct DB name.\n"
    assert_raises(SystemExit, msg) { @cli.switch("aaa") }
  end

  def test_switch_blank
    msg = "Error: No such directroy ``. Please enter a correct DB name.\n"
    assert_raises(SystemExit, msg) { @cli.switch("") }
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
    msg =  "Error: Unavailable format `aaa`. Please enter a available format `json` or `yaml`.\n"
    assert_raises(SystemExit, msg) { @cli.invoke(:show, ['oosaka'], { format: 'aaa'} ) }
  end

  def test_show_unexpected_format
    msg =  "Error: Unavailable format `!@\#$`. Please enter a available format `json` or `yaml`.\n"
    assert_raises(SystemExit, msg) { @cli.invoke(:show, ['oosaka'], { format: '!@#$'}) }
  end

  def test_show_no_such_file
    msg =  "Error: No such file `aaa`. Please enter a correct file name.\n"
    assert_raises(SystemExit, msg) { @cli.invoke(:show, ['aaa']) }
  end

  def test_show_does_not_select_db
    @config.save('')
    msg =  "Error: DB does not set. Make sure that `keg switch DB_NAME`.\n"
    assert_raises(SystemExit, msg) { @cli.show('oosaka') }
  end

  def test_show_db_unknown_directory
    @config.save('aaaa')
    msg =  "Error: Current DB is unknown directory `aaaa`. Make sure that `keg switch DB_NAME`.\n"
    assert_raises(SystemExit, msg) { @cli.show('oosaka') }
  end

  def test_current_success
    out, err = capture_io { @cli.current }
    assert_equal "glean-daimon-lunch\n", out
  end

  def test_current_does_not_select_db
    @config.save('')
    msg =  "Error: DB does not set. Make sure that `keg switch DB_NAME`.\n"
    assert_raises(SystemExit, msg) { @cli.current }
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
    msg =  "Error: Unavailable format `aaa`. Please enter a available format `json` or `yaml`.\n"
    assert_raises(SystemExit, msg) { @cli.invoke(:show_all, [], { format: 'aaa' }) }
  end

  def test_show_all_no_such_directory
    @config.save("aaaa")
    msg =  "Error: Current DB is unknown directory `aaaa`. Make sure that `keg switch DB_NAME`.\n"
    assert_raises(SystemExit, msg) { @cli.invoke(:show_all) }
  end

  def test_show_all_db_does_not_set
    @config.save('')
    msg =  "Error: DB does not set. Make sure that `keg switch DB_NAME`.\n"
    assert_raises(SystemExit, msg) { @cli.invoke(:show_all) }
  end

  def test_show_all_unexpected_format
    msg =  "Error: Unavailable format `!@\#$`. Please enter a available format `json` or `yaml`.\n"
    assert_raises(SystemExit, msg) { @cli.invoke(:show_all, [], { format: '!@#$' }) }
  end
end
