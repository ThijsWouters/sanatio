require "sanatio/field_validator"
require "sanatio/class_validator"

module Sanatio::ValidatorFactory
  def self.create(target)
    if target.instance_of? Class
      Sanatio::ClassValidator.new
    else
      Sanatio::FieldValidator.new(target)
    end
  end
end
