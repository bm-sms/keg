require_relative 'test_helper'

class TomlTest < Minitest::Test
  def setup
    @cli = Keg::CLI.new
    @database = Keg::Core.new(ENV["HOME"])
    @database.switch('example')
  end

  def test_string
    out, err = capture_io { @cli.invoke(:show, ['string']) }
    str = %Q(The quick brown fox jumps over the lazy dog.)
    result = { str1: str, str2: str, str3: str }
    assert_equal result.to_json + "\n", out
  end

  def test_number
    out, err = capture_io { @cli.invoke(:show, ['number']) }
    result = { int1: 99, int2: -17, int3: 10, int4: 2016,
               flt1: 0.01, flt2: 1.5, flt3: -0.01, flt4: 5e+22,
               flt5: -2E-2, flt6: 6.626e-34 }
    assert_equal result.to_json + "\n", out
  end

  def test_array
    out, err = capture_io { @cli.invoke(:show, ['array']) }
    result = {
      arr1: [1, 2, 3], arr2: ["red", "yellow", "green"],
      arr3: [[1, 2], [3, 4, 5]],
      arr4: ["all", "strings", "are the same", "type"],
      arr5: [[1, 2], ["a", "b", "c"]],
      arr6: [1, 2, 3], arr7: [1, 2]
    }
    assert_equal result.to_json + "\n", out
  end

  def test_table
    out, err = capture_io { @cli.invoke(:show, ['table']) }
    result = {
                name: { first: "Tom", last: "Preson-Werner" },
                point: { x: 1, y: 2 },
                table: {
                  "key" => "value", "bare_key" => "value", "bare-key" => "value",
                  "127.0.0.1" => "value", "character encoding" => "value",
                  "tater.man" => { type: "pug" }
                },
                products: [
                  { name: "Hammer", sku: 73375948 },
                  {},
                  { name: "Nail", sku: 74329824, color: "gray" }
                ],
                fruit: [
                  { name: "apple",
                  physical: [
                    { color: "red", shape: "round" }
                  ],
                  variey: [
                    { name: "red delicious" },
                    { name: "granny smith" }
                  ] },
                  { name: "banana",
                  variey: [
                    { name: "plantain" }
                  ] }
                ]
              }
      assert_equal result.to_json + "\n", out
  end

  def test_tree
    out, err = capture_io { @cli.invoke(:show, ['tree/node']) }
    result = { name: "example user", email: "toml@example.com" }
    assert_equal result.to_json + "\n", out
  end

  def test_other
    out, err = capture_io { @cli.invoke(:show, ['other']) }
    result = {
      bool1: true, bool2: false,
      date1: "1994-05-27 07:32:00 +0000",
      date2: "1994-05-27 00:32:00 -0700",
      date3: "1979-05-27 00:32:00 -0700"
    }
    assert_equal result.to_json + "\n", out
  end
end
