class LessThan
  def initialize(value)
    @value = value
  end

  def skip?(object)
    !object.respond_to?(:<)
  end

  def valid?(object)
    object < @value
  end

  def reason
    :greater_than_or_equal_to
  end

  def params
    [@value]
  end
end
