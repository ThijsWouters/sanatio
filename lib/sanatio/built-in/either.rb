class Either
  def initialize(first_field, second_field, validator_class, *params)
    @first_field = first_field
    @second_field = second_field
    @validator = validator_class.new(*params)
  end

  def skip?(value)
    @validator.skip?(first_value(value)) || @validator.skip?(second_value(value))
  end

  def valid?(value)
    !both?(value) && !neither?(value)
  end

  def reason(value)
    if neither?(value)
      :neither
    else
      if both?(value)
        :both
      end
    end
  end

  def params
    [@first_field, @second_field]
  end

  private

  def both?(value)
    @validator.valid?(first_value(value)) && @validator.valid?(second_value(value))
  end

  def neither?(value)
    !@validator.valid?(first_value(value)) && !@validator.valid?(second_value(value))
  end

  def first_value(value)
    value.send(@first_field)
  end

  def second_value(value)
    value.send(@second_field)
  end
end
