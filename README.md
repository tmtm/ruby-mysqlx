# Mysqlx

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/mysqlx`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mysqlx'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mysqlx

## Usage

## Development

This requires [Protocol Buffers v2.6.1](https://github.com/google/protobuf/releases/tag/v2.6.1).

    % ./bin/setup
    % rake MYSQL_DIR=/tmp/mysql-source-dir

If an error `google/protobuf/descriptor.proto: File not found` occurs, run as:

    % rake MYSQL_DIR=/tmp/mysql-source-dir PROTOC="/path/to/protoc -I /path/to/protobuf/include"

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tmtm/ruby-mysqlx.
