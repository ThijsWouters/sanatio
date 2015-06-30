class NotEqualTo
  def initialize(value)
    @value = value
  end

  def skip?(object)
  end

  def valid?(object)
    object != @value
  end

  def reason
    :equal_to
  end

  def params
    [@value]
  end
end
