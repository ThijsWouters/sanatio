class EqualTo
  def initialize(value)
    @value = value
  end

  def skip?(object)
  end

  def valid?(object)
    object == @value
  end

  def reason(_)
    :not_equal_to
  end

  def params
    [@value]
  end
end
