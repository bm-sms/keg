require_relative 'test_helper'

class ConfigureTest < Minitest::Test
  def setup
    @config = Keg::Configuration.new(ENV["HOME"])
    @path = File.join(ENV["HOME"], '.keg', 'config.yml')
  end

  def test_save_db_name
    assert @config.save_db_name('glean-daimon-lunch')
  end

  def test_load_db_name
    @config.save_db_name('glean-daimon-lunch')
    assert_equal 'glean-daimon-lunch', @config.load_db_name
  end

  def test_load_db_name_no_file_error
    File.delete(@path) if File.exists?(@path)
    assert_nil @config.load_db_name
  end

  def test_load_db_name_file_content_empty
    File.write(@path, '')
    assert_equal nil, @config.load_db_name
  end
end