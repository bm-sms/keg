require_relative 'test_helper'

class ConfigureTest < Minitest::Test
  def setup
    @config = Keg::Configuration.new(ENV["HOME"])
    @path = File.join(ENV["HOME"], '.keg', 'config.yml')
  end

  def test_save
    assert @config.save 'glean-daimon-lunch'
  end

  def test_load
    @config.save 'glean-daimon-lunch'
    assert_equal 'glean-daimon-lunch', @config.load
  end

  def test_load_no_file_error
    File.delete(@path) if File.exists?(@path)
    assert_raises(SystemExit) { @config.load }
  end

  def test_load_file_content_empty
    File.write(@path, '')
    assert_raises(SystemExit) { @config.load }
  end
end
