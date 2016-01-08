require_relative 'test_helper'

class YglCLITest < Minitest::Test
  def setup
    @cli = Ygl::CLI.new
  end

  def test_switch_success
    assert_output(stdout=%Q(switch DataBase 'daimon-lunch'\n), stderr=nil) do 
      @cli.switch("daimon-lunch")
    end
  end

  def test_switch_failure
    # TODO: modify RuntimeError to correct
    assert_raises(RuntimeError) { @cli.switch("aaa") }
  end
end