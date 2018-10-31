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
pnut = Pnut::Client.new(authorization_token: "YOURTOKEN")
pnut.unified
```

If we didn't implement an endpoint yet (check the Gems docs to see what is available), you can use the `request` method to send custom requests:

```ruby
require "pnut"

pnut = Pnut::Client.new
pnut.request("/posts/streams/global")
```

For POST, DELETE, etc. request, the method signature provides the following, with the data parameter defaulting to JSON:

```ruby
pnut.request(
  "/channels/123/messages",
  method: "POST",
  data: {
    text: "Der Test[tm]"
  }
)
```

As a more thorough example, one can request an AppStream access token (where the endpoint expects form-data instead of JSON) and get the body of the response unparsed as a string like this:

```ruby
pnut.request(
  "/oauth/access_token",
  json: false,
  method: "POST",
  raw_response: true,
  data: {
    client_id: "YOUR_CLIENT_ID",
    client_secret: "YOUR_CLIENT_SECRET",
    grant_type: "client_credentials"
  }
)
```

## App Streams

We support a light abstraction over pnut's App Streams, standing on the shoulders of EventMachine and faye-websocket. Given you already have a valid app access token and created a stream with corresponding stream key, you can start it like this:

```ruby
require "pnut/app_stream"

Pnut::AppStream.start(access_token: "…", stream_key: "…")
```

Having every stream message printed to STDOUT is not that useful in itself, therefor you can provide a custom handler to react to them yourself:

```ruby
require "pnut/app_stream"

def on_message(msg)
  p JSON.parse(msg)
end

Pnut::AppStream.start(
  access_token: "…",
  stream_key: "…",
  on_message: method(:on_message)
)
```

If you want to, you can hook into the open and close events too (usefull for automatic reconnection etc.):

```ruby
Pnut::AppStream.start(
  access_token: "…",
  stream_key: "…",
  on_open: method(:puts)
  on_message: method(:puts)
  on_close: method(:puts)
)
```

## User Streams

User streams are pretty much the same from this Gems perspective, except that you don't need to provide a stream_key. Don't forget to handle the first message that gives you your connection_id, as described in [pnut's api docs](https://pnut.io/docs/api/how-to/user-streams)

```ruby
require "pnut/user_stream"

Pnut::UserStream.start(
  access_token: "…",
  on_open: method(:puts),
  on_message: method(:puts),
  on_close: method(:puts)
)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kaiwood/pnut-ruby.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
