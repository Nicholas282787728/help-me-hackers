require 'test_helper'

class LanguageTest < Test::Unit::TestCase
  should_have_many :users
  should_have_many :tasks
  should_validate_presence_of :name
end
