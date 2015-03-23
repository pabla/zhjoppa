require 'test_helper'

class ZhjoppaTest < Minitest::Test
  def test_generate_key
    zhjoppa = Zhjoppa.new
    assert_equal 4, zhjoppa.generate_key.length
  end

  def test_default_configuration
    zhjoppa = Zhjoppa.new
    assert_match 'Certege.ttf', Zhjoppa.configuration.font
    assert_equal 80, Zhjoppa.configuration.font_size
    assert_equal 160, Zhjoppa.configuration.width
    assert_equal 80, Zhjoppa.configuration.height
    assert_equal 4, Zhjoppa.configuration.key_len
  end
end
