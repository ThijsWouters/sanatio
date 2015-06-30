class EqualTo
  def initialize(value)
    @value = value
  end

  def skip?(object)
  end

  def valid?(object)
    object == @value
  end

  def reason
    :not_equal_to
  end

  def params
    [@value]
  end
end
