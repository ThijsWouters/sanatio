require "sanatio/version"
require "sanatio/error"
require "sanatio/validator_factory"

module Sanatio
  module ClassMethods
    def ensure_that(target)
      ValidatorFactory.create(target).tap do |validator|
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
    other.send(:include, InstanceMethods)
    other.send(:extend, ClassMethods)
  end
end
