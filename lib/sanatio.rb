require "sanatio/version"

module Sanatio
  module ClassMethods
    def ensure_that(field)
      Validation.new(field).tap do |validation|
        validations << validation
      end
    end

    def validations
      @validation ||= []
    end
  end

  module InstanceMethods
    def valid?
      errors.empty?
    end

    def errors
      self.class.validations.reject do |validation|
        validation.valid?(self)
      end.map(&Error.method(:new))
    end
  end

  def self.included(other)
    other.include(InstanceMethods)
    other.extend(ClassMethods)
  end

  class Error
    extend Forwardable

    def_delegators :@validation, :field, :reason

    def initialize(validation)
      @validation = validation
    end
  end

  class Validation
    attr_reader :field
    attr_accessor :reason

    def initialize(field)
      @field = field
    end

    def is(&validation_block)
      @validation_block = validation_block
      self
    end

    def valid?(object)
      object.send(@field).instance_eval &@validation_block
    end
  end
end
