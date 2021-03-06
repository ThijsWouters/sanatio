require "sanatio/version"
require "sanatio/class_validator"
require "sanatio/field_validator"
require "sanatio/built-in"

module Sanatio
  module ClassMethods
    def ensure_that(target)
      create(target).tap do |validator|
        validators << validator
      end
    end

    def validators
      @validation ||= []
    end

    private
    def create(target)
      if target.instance_of? Class
        ClassValidator.new
      else
        FieldValidator.new(target)
      end
    end
  end

  module InstanceMethods
    def valid?
      errors.empty?
    end

    def errors
      self.class.validators.reject do |validator|
        validator.skip?(self)
      end.reject do |validator|
        validator.valid?(self)
      end.map do |validator|
        validator.error(self)
      end
    end
  end

  def self.included(other)
    other.send(:include, InstanceMethods)
    other.send(:extend, ClassMethods)

    other.send(:include, Sanatio::BuiltIn)
  end
end
