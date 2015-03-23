require 'test_helper'
require 'generators/zhjoppa/install_generator'

class InstallGeneratorTest < Rails::Generators::TestCase
  tests Zhjoppa::Generators::InstallGenerator
  destination File.expand_path('../tmp', File.dirname(__FILE__))
  setup :prepare_destination

  test 'Assert all files are properly created' do
    run_generator
    assert_file 'app/views/zhjoppa/_zhjoppa.html.erb'
  end
end
