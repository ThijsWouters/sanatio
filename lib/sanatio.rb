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
      self.class.validations.map do |validation|
        Error.new(validation.field, validation.reason)
      end
    end
  end

  def self.included(other)
    other.include(InstanceMethods)
    other.extend(ClassMethods)
  end

  Error = Struct.new(:field, :reason)

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
  end
end
