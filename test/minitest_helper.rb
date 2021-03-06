require 'sanatio'

require 'minitest'
require 'minitest/autorun'

include Sanatio::BuiltIn

def assert_valid(object)
  assert(object.valid?, 'I expected object to be valid')
  assert_empty(object.errors, 'I did not expect any errors')
end

def refute_valid(object, options = {})
  options[:params] ||= []

  refute(object.valid?, 'I expected object to be invalid')
  refute_empty(object.errors, 'I expected an error')
  error = object.errors.first
  if options[:field]
    assert_equal(options[:field], error.field, "I expected the field #{options[:field]}")
  else
    refute_respond_to(error, :field, "I do not expect the error having a field method")
  end
  assert_equal(options[:reason], error.reason, "I expected the reason #{options[:reason]}")
  assert_equal(options[:params], error.params, "I expected the params #{options[:params]}")
end
