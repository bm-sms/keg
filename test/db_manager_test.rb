require_relative 'test_helper'

class DBManagerTest < Minitest::Test
  def setup
    @db_manager = Keg::DBManager.new(ENV["HOME"])
    @configuration = Keg::Configuration.new(ENV["HOME"])
    @oosaka = {"name" => "東麻布 逢坂",
               "url"  => "http://tabelog.com/tokyo/A1314/A131401/13044558/"}
    @ranma  = {"name" => "蘭麻",
               "url"  =>"http://tabelog.com/tokyo/A1314/A131401/13034212/"}
  end

  def test_switch_success
    assert @db_manager.switch 'glean-daimon-lunch'
  end

  def test_switch_unknown_dir
    assert_raises(SystemExit) { @db_manager.switch 'aaa' }
  end

  def test_switch_blank
    assert_raises(SystemExit) { @db_manager.switch '' }
  end

  def test_show_success
    @db_manager.switch 'glean-daimon-lunch'
    assert_equal @oosaka, @db_manager.show('oosaka')
  end

  def test_show_unkwon_file
    @db_manager.switch 'glean-daimon-lunch'
    assert_raises(SystemExit) { @db_manager.show('aaa') }
  end

  def test_show_blank
    @db_manager.switch 'glean-daimon-lunch'
    assert_raises(SystemExit) { @db_manager.show('') }
  end

  def test_current_success
    @db_manager.switch 'glean-daimon-lunch'
    assert_equal 'glean-daimon-lunch', @db_manager.current
  end

  def test_current_db_does_not_set
    @configuration.save ''
    assert_raises(SystemExit) { @db_manager.current }
  end

  def test_current_db_is_unknown_directroy
    @configuration.save 'aaa'
    assert_raises(SystemExit) { @db_manager.current }
  end

  def test_current_db_is_blank
    @configuration.save ''
    assert_raises(SystemExit) { @db_manager.current }
  end

  def test_show_all_success
    @db_manager.switch 'glean-daimon-lunch'
    assert_equal [@oosaka, @ranma], @db_manager.show_all
  end
end
