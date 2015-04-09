require "sanatio/version"
require "sanatio/error"
require "sanatio/valdator"
require "sanatio/class_validator"

module Sanatio
  module ClassMethods
    def ensure_that(target)
      if target.instance_of? Class
        ClassValidator.new.tap do |validator|
          validators << validator
        end
      else
        Validator.new(target).tap do |validator|
          validators << validator
        end
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
