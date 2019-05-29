# danger-simplecov_json

[![License](http://img.shields.io/badge/license-MIT-green.svg?style=flat)](LICENSE.txt)
[![Gem](https://img.shields.io/gem/v/danger-simplecov_json.svg?style=flat)](http://rubygems.org/gems/danger-simplecov_json)
[![Build Status](https://travis-ci.org/marcelofabri/danger-simplecov_json.svg?branch=master)](https://travis-ci.org/marcelofabri/danger-simplecov_json)

Report your Ruby app test suite code coverage in [Danger](https://github.com/danger/danger).

Before using this plugin, you need to setup your project to use [SimpleCov](https://github.com/colszowka/simplecov)
to get code coverage information and [simplecov-json](https://github.com/vicentllongo/simplecov-json) to format
it as JSON.

## How does it look?

<table>
  <thead>
    <tr>
      <th width="50"></th>
      <th width="100%" data-kind="Message">
          1 Message
      </th>
     </tr>
  </thead>
  <tbody>

    <tr>
      <td>:book:</td>
      <td data-sticky="true">Code coverage is now at 99.15% (1512/1525 lines)</td>
    </tr>
  </tbody>
</table>

## Installation

Add this line to your Gemfile:

```ruby
gem 'danger-simplecov_json'
```

## Usage

Just add this line to your `Dangerfile`:

```ruby
simplecov.report 'coverage/coverage.json'
```

You can also make the message not [sticky](http://danger.systems/reference.html):

```ruby
simplecov.report('coverage/coverage.json', sticky: false)
```

### Individual File coverage

In addition, you can see coverage for the files you've added or modified in git:

```ruby
simplecov.individual_report('coverage/coverage.json', Dir.pwd)
```

## License

MIT

## Development

1. Clone this repo
2. Run `bundle install` to setup dependencies.
3. Run `bundle exec rake spec` to run the tests.
4. Use `bundle exec guard` to automatically have tests run as you make changes.
5. Make your changes.
