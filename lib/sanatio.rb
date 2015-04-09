require "sanatio/version"
require "sanatio/error"
require "sanatio/valdator"

module Sanatio
  module ClassMethods
    def ensure_that(field)
      Validator.new(field).tap do |validator|
        validators << validator
      end
    end

    def validators
      @validation ||= []
    end
  end

  module InstanceMethods
    def valid?
      errors.empty?
    end

    def errors
      self.class.validators.reject do |validator|
        validator.valid?(self)
      end.map(&Error.method(:new))
    end
  end

  def self.included(other)
    other.include(InstanceMethods)
    other.extend(ClassMethods)
  end
end
