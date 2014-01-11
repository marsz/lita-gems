# lita-gems

[![Build Status](https://travis-ci.org/marsz/lita-gems.png?branch=master)](https://travis-ci.org/marsz/lita-gems)

Lita (robot) handler for querying RubyGems.org through official API gem (https://github.com/rubygems/gems).

## Installation

Add lita-gems to your Lita instance's Gemfile:

``` ruby
gem "lita-gems"
```

## Configuration

## Usage

`lita gem rails` : get infomation of gem 'rails' from rubygems.org

```
version: 4.0.2
rubygems: http://rubygems.org/gems/rails
homepage: http://www.rubyonrails.org
documentation: http://api.rubyonrails.org
source code: http://github.com/rails/rails
```

`lita gem q cache` : search gems with keyword 'cache' from rubygems.org

```
http://rubygems.org/search?query=cache
rack-cache( 1.2 ) : http://rubygems.org/gems/rack-cache
linecache( 0.46 ) : http://rubygems.org/gems/linecache
memcache-client( 1.8.5 ) : http://rubygems.org/gems/memcache-client
linecache19( 0.5.12 ) : http://rubygems.org/gems/linecache19
memcached( 1.7.2 ) : http://rubygems.org/gems/memcached
...
```

## License

[MIT](http://opensource.org/licenses/MIT)
