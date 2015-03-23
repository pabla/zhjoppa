ENV['RAILS_ENV'] = 'test'

require 'minitest/autorun'
require 'rack/test'
require 'rails/generators/test_case'
require 'zhjoppa'

ActiveSupport::TestCase.test_order = :random
