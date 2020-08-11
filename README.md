# Api Authorization (The gem is in development)
A multiple role-based authorization, based on controller actions.

![Tests](https://github.com/montedelgallo/api-authorization/workflows/Ruby/badge.svg?branch=master)
![Ruby Gem](https://github.com/montedelgallo/api-authorization/workflows/Ruby%20Gem/badge.svg?branch=master)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

##### Database Model
![db_model](model.jpg)
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
2. Next populate permissions table with your controllers and actions run:
```bash
$ rails api_auth:create_permissions
```
3. Include the Authorization module on your `ApplicationController` :
```ruby
  include ActionController::Helpers
  include ApiAuthorization
  enable_role_authorization
```
4. DONE

##### More [CLI commands](cli.MD)

## Contributing
Feel free to suggest a feature or report a bug.
#### [Code Of Conduct](CODE_OF_CONDUCT.md)

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
