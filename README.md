# OpenBadges

Provides some objects to make it easy to work with the OpenBadges [issuer API](https://github.com/mozilla/openbadges/wiki/Issuer-API). Right
now this only includes the ability to create the [Assertion JSON](https://github.com/mozilla/openbadges/wiki/Assertions) necessary when responding
to a assertion request from OpenBadges.

## Installation

Add this line to your application's Gemfile:

    gem 'open_badges'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install open_badges

## Usage

Using this in a Rails app is really simple.  Let's say you have a `BadgesController`
with a `assertion` action that will serve up the assertion JSON.  Here is how you would use it:

```ruby
class BadgesController < ApplicationController
  def assertion
    assertion = OpenBadges::Assertion.new
    # You'd probably fill in these values from some `badges` table and
    # user information
    assertion.email = "<email>"
    assertion.issued_on = Time.now
    assertion.name = "Completed Level 1 of Something"
    assertion.description = "Completed Level 1 of Something"
    assertion.badge_url = "http://www.codeschool.com/badges/1"
    assertion.criteria_url = "http://www.codeschool.com/badges/1"

    render json: assertion
  end
end
```

And then setup a couple of pieces of information about you, the issuer, in the respective environment:

```ruby
# in config/environments/production.rb
  config.after_initialize do
    OpenBadges.issuer_url = "http://www.codeschool.com"
    OpenBadges.issuer_name = "Code School"
  end
```

This would create JSON that looked like this:

```javascript
{
  :recipient=>"sha256$56ad781803f326ddab2f5eaa270964d40d43a11abd193fdb121334f1e653263a", 
  :salt=>"c1be0242548c455c654e720ae304e5b6", 
  :issued_on=>"2012-08-26", 
  :badge=>{
    :version=>"0.5.0", 
    :name=>"Completed Level 1 of Something", 
    :image=>"http://www.codeschool.com/badges/1", 
    :description=>"Completed Level 1 of Something", 
    :criteria=>"http://www.codeschool.com/badges/1/criteria", 
    :issuer=>{
      :origin=>"http://www.codeschool.com", 
      :name=>"Code School", 
      :org=>nil, 
      :contact=>nil
    }
  }
}
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
