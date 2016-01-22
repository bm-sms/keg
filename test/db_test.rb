require_relative './test_helper'

class YglDBTest < Minitest::Test
  def setup
    @db = YGL::Database
  end

  def test_switch_success
    assert_equal "daimon-lunch".size, @db.switch("daimon-lunch")
  end

  def test_switch_no_such_directroy
    assert_equal nil, @db.switch("aaa")
  end

  def test_get_toml_success
    @db.switch("daimon-lunch")
    result = {"name" => "東麻布 逢坂",
              "url" => "http://tabelog.com/tokyo/A1314/A131401/13044558/"}
    assert_equal result, @db.get_toml('oosaka')
  end

  def test_get_toml_no_such_file
    @db.switch("daimon-lunch")
    assert_equal nil, @db.get_toml('aaa')
  end

  def test_current_success
    @db.switch("daimon-lunch")
    assert_equal "daimon-lunch", @db.current
  end

  def test_each
    @db.switch("daimon-lunch")
    result = []
    result[0] = {"name" => "東麻布 逢坂",
                 "url"  => "http://tabelog.com/tokyo/A1314/A131401/13044558/"}
    result[1] = {"name" => "蘭麻",
                 "url"  =>"http://tabelog.com/tokyo/A1314/A131401/13034212/"}   
    i = 0
    @db.each do |toml|
      assert_equal result[i], toml
      i += 1
    end
  end
end