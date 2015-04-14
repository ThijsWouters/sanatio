$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'sanatio'

require 'minitest'
require 'minitest/autorun'

def assert_valid(object)
  assert(object.valid?, 'I expected object to be valid')
  assert_empty(object.errors, 'I did not expect any errors')
end

def refute_valid(object, field, reason)
  refute(object.valid?, 'I expected object to be invalid')
  refute_empty(object.errors, 'I expected an error')
  error = object.errors.first
  assert_equal(field, error.field, "I expected the field #{field}")
  assert_equal(reason, error.reason, "I expected the reason #{reason}")
end
