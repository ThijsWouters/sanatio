require 'sanatio'

require 'minitest'
require 'minitest/autorun'

def assert_valid(object)
  assert(object.valid?, 'I expected object to be valid')
  assert_empty(object.errors, 'I did not expect any errors')
end

def refute_valid(object, options = {})
  refute(object.valid?, 'I expected object to be invalid')
  refute_empty(object.errors, 'I expected an error')
  error = object.errors.first
  assert_equal(options[:field], error.field, "I expected the field #{options[:field]}")
  assert_equal(options[:reason], error.reason, "I expected the reason #{options[:reason]}")
end
