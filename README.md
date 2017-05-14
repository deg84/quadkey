# Quadkey [![Build Status](https://travis-ci.org/deg84/quadkey.svg?branch=master)](https://travis-ci.org/deg84/quadkey)

Based off of https://msdn.microsoft.com/en-us/library/bb259689.aspx

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'quadkey'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install quadkey

## Usage

### encode

```ruby
latitude = 35.657976
longitude = -139.745364
precision = 16

quadkey = Quadkey.encode(latitude, longitude, precision)
```

### decode

```ruby
(latitude, longitude, precision) = Quadkey.decode('0221130032120022')
```

### neighbors

```ruby
Quadkey.neighbors('0221130032120022')
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/deg84/quadkey. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

