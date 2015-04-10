# Sanatio

![Build status](https://travis-ci.org/ThijsWouters/sanatio.svg)

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

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/sanatio/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
