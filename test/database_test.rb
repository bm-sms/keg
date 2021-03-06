require_relative 'test_helper'

class CoreTest < Minitest::Test
  def setup
    @core = Keg::Core.new(ENV['HOME'])
    @configuration = Keg::Configuration.new(ENV['HOME'])
    @oosaka = { 'name' => '東麻布 逢坂',
                'url'  =>  'http://tabelog.com/tokyo/A1314/A131401/13044558/' }
    @ranma  = { 'name' => '蘭麻',
                'url'  =>  'http://tabelog.com/tokyo/A1314/A131401/13034212/' }
  end

  def test_switch_success
    assert @core.switch 'glean-daimon-lunch'
  end

  def test_switch_no_such_directory
    assert_raises(RuntimeError) { @core.switch('aaa') }
  end

  def test_switch_blank
    assert_raises(RuntimeError) { @core.switch('') }
  end

  def test_select_success
    @core.switch 'glean-daimon-lunch'
    assert_equal @oosaka, @core.select('oosaka')
  end

  def test_select_no_such_file
    @core.switch 'glean-daimon-lunch'
    assert_raises(Errno::ENOENT) { @core.select('aaa') }
  end

  def test_select_blank
    @core.switch 'glean-daimon-lunch'
    assert_raises(Errno::ENOENT) { @core.select('') }
  end

  def test_select_current_db_is_unknown
    @configuration.save 'aaa'
    assert_raises(RuntimeError) { @core.select('oosaka') }
  end

  def test_current_success
    @core.switch 'glean-daimon-lunch'
    assert_equal 'glean-daimon-lunch', @core.current
  end

  def test_current_db_does_does_not_set
    @configuration.save ''
    assert_raises(RuntimeError) { @core.current }
  end

  def test_current_db_is_unknown_directory
    @configuration.save 'aaa'
    assert_equal 'aaa', @core.current
  end

  def test_select_all
    @core.switch('glean-daimon-lunch')
    assert_equal [@oosaka, @ranma], @core.select_all
  end

  def test_select_all_current_db_is_unknown
    @configuration.save 'aaa'
    assert_raises(RuntimeError) { @core.select_all }
  end
end
