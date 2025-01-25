# ActiveRecordValueObjects

A simple gem to allow you to store value objects in your ActiveRecord models backed by jsonb columns.

## Motivation

Sometimes you want to store structured data in a jsonb column in your database. This gem allows you to define a value object that can be stored in a jsonb column and provides a simple way to define the schema of the value object.

This lets you store objects without needing to do complex joins or create additional tables.
## Example

```ruby
class Address < ActiveRecordValueObjects::ValueObject
  attribute :street, Types::String
  attribute :city, Types::String
  attribute :state, Types::String
  attribute :zip, Types::String
end

class User < ApplicationRecord
  value_attribute :address, Address 
end
```

Values are immutable by default, but you can easily make copies of them with changes:

```ruby
new_address = Address.new(street: '123 Main St', city: 'Springfield', state: 'IL', zip: '62701')
  .copy_with(city: 'Chicago')
```
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_record_value_objects'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_record_value_objects

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/active_record_value_objects. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ActiveRecordValueObjects project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/active_record_value_objects/blob/master/CODE_OF_CONDUCT.md).
