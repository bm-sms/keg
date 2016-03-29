require_relative 'test_helper'

class DBTest < Minitest::Test
  def setup
    @db = Keg::Database.new(ENV["HOME"])
    @path = File.join(ENV["HOME"], '.keg', 'config.yml')
  end

  def test_use_success
    assert @db.use("glean-daimon-lunch")
  end

  def test_use_no_such_directroy
    assert_raises(SystemExit) { @db.use("aaa") }
  end

  def test_select_success
    @db.use("glean-daimon-lunch")
    result = {"name" => "東麻布 逢坂",
              "url" => "http://tabelog.com/tokyo/A1314/A131401/13044558/"}
    assert_equal result, @db.select('oosaka')
  end

  def test_select_no_such_file
    @db.use("glean-daimon-lunch")
    assert_raises(SystemExit) { @db.select('aaa') }
  end

  def test_select_all
    @db.use("glean-daimon-lunch")
    result = Array.new
    result[0] = {"name" => "東麻布 逢坂",
                 "url"  => "http://tabelog.com/tokyo/A1314/A131401/13044558/"}
    result[1] = {"name" => "蘭麻",
                 "url"  =>"http://tabelog.com/tokyo/A1314/A131401/13034212/"}
    assert_equal @db.select_all, result
  end
end
