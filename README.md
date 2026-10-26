# PayRex Ruby

PayRex Ruby library provides Ruby applications an easy access to the PayRex API. Explore various Ruby classes that represents PayRex API resources on object instantiation.

## Requirements

Ruby 2.3+.

## Gems

If you want to use the package, run the following command:

```sh
gem install payrex-ruby
```

If you want to build the gem from source:

```sh
gem build payrex-ruby.gemspec
```

## Development tests

Run the packaging regression tests before publishing a release:

```sh
gem install minitest -v "~> 5.0"
ruby test/gem_package_test.rb
```

The tests build and install the gem in a temporary directory, then load that
installed artifact without the source checkout on the load path. No API keys
or network requests to PayRex are needed.

## Getting Started

Simple usage looks like:

```ruby
require "payrex-ruby"

payrex_client = Payrex::Client.new("sk_test_...")
payrex_client.payment_intents.retrieve("pi_...")

payrex_client.payment_intents.create(
  amount: 10000,
  currency: "PHP",
  description: "Dino Treat",
  payment_methods: ["gcash"]
)
```

## Handle errors

```ruby
begin
  payrex_client = Payrex::Client.new("sk_test_...")
  payrex_client.payment_intents.retrieve("pi_...")
rescue Payrex::Errors::BaseError => e
  # Handle error
  puts e.errors.first.code
  puts e.errors.first.detail
  puts e.errors.first.parameter
end
```

## Verify webhook signature

```ruby
begin
  payload = "{\"id\":\"evt_...\",\"resource\":\"event\",\"type\":\"payment_intent.succeeded\",\"data\":{..."
  signature_header = "t=1715236958,te=,li=..."
  webhook_secret_key = "whsk_..."

  payrex_client.webhooks.parse_event(
    payload: payload,
    signature_header: signature_header,
    webhook_secret_key: webhook_secret_key
  )
rescue Payrex::Errors::SignatureVerificationError => e
  # Handle invalid signature
  e.errors.first
end
```
