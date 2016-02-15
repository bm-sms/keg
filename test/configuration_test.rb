require_relative 'test_helper'

class ConfigureTest < Minitest::Test
  def setup
    @config = Keg::Configuration
  end

  def test_load_db_name
    assert_equal 'glean-daimon-lunch', @config.load_db_name
  end
end