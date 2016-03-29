require_relative 'test_helper'

class DBTest < Minitest::Test
  def setup
    @database = Keg::Database.new(ENV["HOME"])
    @configuration = Keg::Configuration.new(ENV["HOME"])
    @oosaka = { "name" => "東麻布 逢坂",
                "url"  =>  "http://tabelog.com/tokyo/A1314/A131401/13044558/" }
    @ranma  = { "name" => "蘭麻",
                "url"  =>  "http://tabelog.com/tokyo/A1314/A131401/13034212/" }
  end

  def test_switch_success
    assert @database.switch "glean-daimon-lunch"
  end

  def test_switch_no_such_directory
    assert_raises(SystemExit) { @database.switch "aaa" }
  end

  def test_switch_blank
    assert_raises(SystemExit) { @database.switch "" }
  end

  def test_select_success
    @database.switch "glean-daimon-lunch"
    assert_equal @oosaka, @database.select("oosaka")
  end

  def test_select_no_such_file
    @database.switch "glean-daimon-lunch"
    assert_raises(SystemExit) { @database.select("aaa") }
  end

  def test_select_blank
    @database.switch "glean-daimon-lunch"
    assert_raises(SystemExit) { @database.select("") }
  end

  def test_current_success
    @database.switch "glean-daimon-lunch"
    assert_equal "glean-daimon-lunch", @database.current
  end

  def test_current_db_does_does_not_set
    @configuration.save ""
    assert_raises(SystemExit) { @database.current }
  end

  def test_current_db_is_unknown_directory
    @configuration.save "aaa"
    assert_raises(SystemExit) { @database.current }
  end

  def test_select_all
    @database.switch("glean-daimon-lunch")
    assert_equal [@oosaka, @ranma],@database.select_all
  end
end
