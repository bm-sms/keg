require_relative './test_helper'

class YglDBTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Ygl::VERSION
  end

  def test_switch
    assert Ygl::DB.switch("daimon-lunch")
  end

  def test_get_toml
    Ygl::DB.switch("daimon-lunch")
    result = {"name" => "東麻布 逢坂",
                  "url" => "http://tabelog.com/tokyo/A1314/A131401/13044558/"}
    assert_equal result, Ygl::DB.get_toml('oosaka')
  end

  def test_db_name
    Ygl::DB.switch("daimon-lunch")
    assert_equal "daimon-lunch", Ygl::DB.current
  end
end