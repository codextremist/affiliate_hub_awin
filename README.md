# AffiliateHub Awin

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'affiliate_hub_awin'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install affiliate_hub_awin

## Usage

### Rails

Create a `initializers/affiliate_hub.rb` with your affiliates configuration files

Instructions to create your api token can be found in http://wiki.awin.com/index.php/API_authentication

To get your publisher id visit https://ui.awin.com/login and log yourself in. In the top right corner of the screen there will be the name of the account and beside it the publisher id in parenthesis.

```ruby
AffiliateHub.setup do |config|

  config.setup :awin do |c|
    c.base_uri     = 'https://api.awin.com'
    c.api_token    = 'your_api_token'
    c.publisher_id = 'your_publisher_id'
  end

end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run
the tests. You can also run `bin/console` for an interactive prompt that will allow you to
experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new
version, update the version number in `version.rb`, and then run `bundle exec rake release`, which
will create a git tag for the version, push git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/codextremist/affiliate_hub.
This project is intended to be a safe, welcoming space for collaboration, and contributors are
expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

