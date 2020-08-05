# Api Authorization 
A multiple role-based authorization, based on controller actions.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'api_authorization'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install api_authorization
```

## Usage
1. After you have created your users_table(through devise or manually) next run 
```bash
$ rails api_auth:initialize
```
2. Now to populate permissions table with your controllers and actions run:
```bash
$ rails api_auth:create_permissions
```
3. Now Include the Authorization module on your `ApplicationController` :
```ruby
  include ActionController::Helpers
  include ApiAuthorization
  enable_role_authorization
```
4. DONE

##### More CLI commands will be published soon

## Contributing
Feel free to suggest a feature or report a bug.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
