require "sanatio/field_validator"
require "sanatio/class_validator"

module Sanatio
  module ValidatorFactory
    def self.create(target)
      if target.instance_of? Class
        ClassValidator.new
      else
        FieldValidator.new(target)
      end
    end
  end
end
