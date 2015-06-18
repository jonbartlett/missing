require_relative '../test/test_helper'
require_relative '../lib/photo'
require 'pry'

class TestPhoto < MiniTest::Test
  def setup
    @aphoto = Missing::Photo.new(Dir['./test/files/master_library/*.jpg'].first)
  end

  def teardown
  end

  def test_photo_class_instantiated
    assert_instance_of Missing::Photo, @aphoto 
  end

  def test_photo_has_md5_checksum
    assert_equal false, @aphoto.md5.nil?
  end
  #
  #"2286559df7e7e66594d72cedc31a5676"
end
