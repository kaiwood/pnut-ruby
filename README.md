# pnut

Convenient wrapper library around the [pnut.io](https://pnut.io) API for Ruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pnut'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pnut

## Usage

The goal of the project is to provide a convenient method for every possible endpoint. For example, if you want to fetch the global timeline and get back struct containing "meta" and "data" as described in the [official documentation of the pnut.io API](https://pnut.io/docs/api/implementation/overview):

```ruby
require "pnut"

pnut = Pnut::Client.new
response = pnut.global

p response.meta # meta response with HTTP status code etc.
p response.data # data response, an array of the current posts
```

Most endpoints need a proper Bearer token for authorization. Simply initialize like this to get access:

```ruby
pnut = Pnut::Client.new(:authorization_token: "YOURTOKEN")
pnut.unified
```

If we didn't implement an endpoint yet (check the Gems docs to see what is available), you can use the `request` method to send custom requests:

```ruby
require "pnut"

pnut = Pnut::Client.new
pnut.request("/posts/streams/global")
```

For POST, DELETE, etc. request, the method signature provides the following:

```ruby
pnut.request(
  "/channels/123/messages",
  method: "POST",
  data: {
    text: "Der Test[tm]"
  }
)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kaiwood/pnut-ruby.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
