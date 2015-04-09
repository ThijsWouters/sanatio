class Sanatio::Validator
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
