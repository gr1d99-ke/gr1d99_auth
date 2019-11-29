# Gr1d99Auth

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/gr1d99_auth`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gr1d99_auth'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gr1d99_auth

## Usage

### Rails
1. Add `gem 'gr1d99_auth'` to your gemfile
2. Create a file named `gr1d99_auth.rb` in **config/initializers** directory and add required configurations.

   It is worth noting that `gr1d99_auth` gem offers minimal configurations to enable the gem to work correctly.
   
   These configurations are:
   1. **jwt_key** - this is just a random string that will be used to encode/decode jwt
   2. **jwt_verify** - value can either be **true** or **false**, this specifies whether the jwt should be verified during decoding.
   3. **jwt_algorithm** - specify the algorithm that should be used, currently the tested algorithms and verified that they work correctly is `HS512` and `HS256`, you are highly recommended to use any of them.
   4. **jwt_exp** - specify the time in seconds that the token should be valid
   5. **time_zone** - this ensures that the `jwt_exp` is set appropriately.
   
   example:
   in **config/initializers/gr1d99_auth.rb** you would typically have this setup.
   
   ```ruby
   Gr1d99Auth.configure do |config|
     config.jwt_key = "my-jwt-key"
     config.jwt_verify = true
     config.jwt_algorithm = 'HS512'
     config.jwt_exp = 3600
     config.time_zone = "Africa/Nairobi"
   end
   ```
3. In your controller, typically `authentication_controller.rb`, you would encode your payload by
   ```ruby
   payload = { id: user.id, email: user.email, roles: user.roles.pluck(:name) }
   Gr1d99Auth::JWT.encode(payload)
   ```
4. To decode token
   ```ruby
   token = response.headers["HTTP_X_ACCESS_TOKEN"]
   Gr1d99Auth::JWT.decode(token)
   ```
   
5. You should also handle errors raised during decoding, these errors are.
   1. `JWT::DecodeError`
   2. `JWT::VerificationError`
   3. `JWT::IncorrectAlgorithm`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/gr1d99_auth. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Gr1d99Auth project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/gr1d99_auth/blob/master/CODE_OF_CONDUCT.md).
