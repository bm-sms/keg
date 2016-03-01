require_relative 'test_helper'

class DBTest < Minitest::Test
  def setup
    @db = Keg::Database.new(ENV["HOME"])
    @path = File.join(ENV["HOME"], '.keg', 'config.yml')
  end

  def test_switch_success
    assert @db.switch("glean-daimon-lunch")
  end
  
  def test_contents_success
    @db.switch("glean-daimon-lunch")
    result = {"name" => "東麻布 逢坂",
              "url" => "http://tabelog.com/tokyo/A1314/A131401/13044558/"}
    assert_equal result, @db.contents('oosaka')
  end

  def test_contents_invalid_config
    File.write(@path, 'aaa')
    assert_raises(TypeError) { @db.contents('oosaka') }
  end

  def test_current_success
    @db.switch("glean-daimon-lunch")
    assert_equal "glean-daimon-lunch", @db.current
  end

  def test_current_faild
    config = Keg::Configuration.new(ENV["HOME"])
    config.save_db_name('')
    assert_equal '', @db.current
  end

  def test_current_invaild_config
    File.write(@path, 'aaa')
    assert_equal nil, @db.current
  end

  def test_each
    @db.switch("glean-daimon-lunch")
    result = Array.new
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