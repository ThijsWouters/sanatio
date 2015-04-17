class LessThanOrEqualTo
  def initialize(value)
    @value = value
  end

  def skip?(object)
    !object.respond_to?(:<=)
  end

  def valid?(object)
    object <= @value
  end

  def reason
    :greater_than
  end

  def params
    [@value]
  end
end
