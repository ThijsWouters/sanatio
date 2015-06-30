# Sanatio

![Build status](https://travis-ci.org/ThijsWouters/sanatio.svg)
[![Gem Version](https://badge.fury.io/rb/sanatio.svg)](http://badge.fury.io/rb/sanatio)
[![Code Climate](https://codeclimate.com/github/ThijsWouters/sanatio/badges/gpa.svg)](https://codeclimate.com/github/ThijsWouters/sanatio)

Sanatio is a gem that does validation. It has no external dependencies.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sanatio'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sanatio

## Usage

### One-time validation

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

  ensure_that(:name).is { !nil? }.reason = :not_nil
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

  ensure_that(self).is { !name.nil? }.reason = :name_not_nil
end

person = Person.new(nil)
error = person.errors.first
error.reason # :name_not_nil
person.valid? # false
```

### Skipping validations

You can skip validations if they are not needed or if they cannot run.

```ruby
class Person
  include Sanatio

  def initialize(name)
    @name = name
  end

  attr_reader :name

  # NilClass#empty? does not exist, so the validation will fail when the name is nil.
  ensure_that(:name).is { !empty? }.skip_if { nil? }.reason = :not_empty
end

Person.new(nil).valid? # true
Person.new("").valid? # false
```

### Built-in validations

#### Present

This validation fails when the value is not present. Or empty when appropriate.

```ruby
class Person
  include Sanatio

  def initialize(name)
    @name = name
  end

  attr_reader :name

  ensure_that(:name).is Present
end

Person.new(nil).valid? #false
Person.new("").valid? #false
Person.new("Test Testington").valid? #true
```

#### GreaterThanOrEqualTo

This validation fails when the value is smaller than a given value.

```ruby
class Person
  include Sanatio

  def initialize(age)
    @age = age
  end

  attr_reader :age

  ensure_that(:age).is GreaterThanOrEqualTo, 18
endO

Person.new(nil).valid? #true, validation is skipped
Person.new(15).valid? #false
Person.new(18).valid? #true
```

#### GreaterThan

This validation fails when the value is smaller than or equal a given value.

```ruby
class Person
  include Sanatio

  def initialize(age)
    @age = age
  end

  attr_reader :age

  ensure_that(:age).is GreaterThan, 18
endO

Person.new(nil).valid? #true, validation is skipped
Person.new(15).valid? #false
Person.new(19).valid? #true
```

#### LessThanOrEqualTo

This validation fails when the value is greater than a given value.

```ruby
class Person
  include Sanatio

  def initialize(age)
    @age = age
  end

  attr_reader :age

  ensure_that(:age).is LessThanOrEqualTo, 18
endO

Person.new(nil).valid? #true, validation is skipped
Person.new(15).valid? #true
Person.new(19).valid? #false
```

#### LessThan

This validation fails when the value is greater than or equal to a given value.

```ruby
class Person
  include Sanatio

  def initialize(age)
    @age = age
  end

  attr_reader :age

  ensure_that(:age).is LessThan, 18
endO

Person.new(nil).valid? #true, validation is skipped
Person.new(15).valid? #true
Person.new(19).valid? #false
```

#### EqualTo

This validation fails when the field is not equal to the given value.

```ruby
class Person
  include Sanatio

  def initialize(age)
    @age = age
  end

  attr_reader :age

  ensure_that(:age).is EqualTo, 18
endO

Person.new(nil).valid? #false
Person.new(15).valid? #false
Person.new(18).valid? #true
```

#### NotEqualTo

This validation fails when the field is equal to the given value.

```ruby
class Person
  include Sanatio

  def initialize(age)
    @age = age
  end

  attr_reader :age

  ensure_that(:age).is NotEqualTo, 18
endO

Person.new(nil).valid? #true
Person.new(15).valid? #true
Person.new(18).valid? #false
```

#### OneOf

This validation fails when the value is not in the list given.

```ruby
class Person
  include Sanatio

  def initialize(name)
    @name = name
  end

  attr_reader :name

  ensure_that(:name).is OneOf, 'Santa', 'Easter Bunny'
end

Person.new(nil).valid? #false
Person.new("Test Testington").valid? #false
Person.new("Easter Bunny").valid? #true
Person.new("Santa").valid? #true
```

#### Valid

This validation fails when the value is not valid.

```ruby
class Address
  include Sanatio

  def initialize(street)
    @street = street
  end

  attr_reader :street

  ensure_that(:street).is Present
end

class Person
  include Sanatio

  def initialize(address)
    @address = address
  end

  attr_reader :address

  ensure_that(:address).is Valid
end

Person.new(Address.new('Alleystreet')).valid? #true
Person.new(Address.new(nil)).valid? #false
Person.new(Address.new(nil)).errors #[Error.new(:field => :address, :reason => :invalid)]
```

#### Matching

This validation fails when the value does not match the provided regex.

```ruby
class Person
  include Sanatio

  def initialize(name)
    @name = name
  end

  attr_reader :name

  ensure_that(:name).is Matching, /Test/
end

Person.new(nil).valid? #false
Person.new("Test Testington").valid? #true
Person.new("DoesNotMatch").valid? #false
Person.new("DoesNotMatch").errors #[Error.new(:field => :name, :reason => :no_match)]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/ThijsWouters/sanatio/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
