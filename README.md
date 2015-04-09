# Sanatio

## One-time validation

If you only need a validation in a single place. You can use a block.

If your block evaluates to a falsey value, then the validation fails with the reason that is given.

With field level validation:

```ruby
class Person
  include Sanatio

  def initialize(name)
    @name = name
  end

  attr_reader :name

  ensure(:name).is { !nil? }.reason = :not_nil
end

person = Person.new(nil)
error = person.errors.first
error.field # :name
error.reason # :not_nil
person.valid? # false
```

Or, with a class level validation:

```ruby
class Person
  include Sanatio

  def initialize(name)
    @name = name
  end

  attr_reader :name

  ensure(self).is { !name.nil? }.reason = :name_not_nil
end

person = Person.new(nil)
error = person.errors.first
error.reason # :name_not_nil
person.valid? # false
```
