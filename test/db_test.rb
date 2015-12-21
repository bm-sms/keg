require 'minitest/autorun'
require_relative 'test_helper'
require_relative '../lib/db'

class DBTest < Minitest::Test
  def test_connect_db
    assert DB.switch("daimon-lunch")
  end

  def test_get_file
    DB.switch("daimon-lunch")
    assert DB.get_file('oosaka')
    DB.close
  end

  def test_db_close
    DB.switch("daimon-lunch")
    DB.get_file('oosaka')
    assert_nil DB.close
  end
end