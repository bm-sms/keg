require_relative './test_helper'

class YglTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Ygl::VERSION
  end

  def test_connect_db
    assert Ygl::DB.switch("daimon-lunch")
  end

  def test_get_file
    Ygl::DB.switch("daimon-lunch")
    assert Ygl::DB.get_file('oosaka')
    Ygl::DB.close
  end

  def test_db_close
    Ygl::DB.switch("daimon-lunch")
    Ygl::DB.get_file('oosaka')
    assert_nil Ygl::DB.close
  end

  def test_db_name
    Ygl::DB.switch("daimon-lunch")
    assert_equal "daimon-lunch", Ygl::DB.name
  end
end
