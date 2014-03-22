# Rhb (Ruby HTML builder)

Lightweight html from ruby code builder. Inspired by [Mab](https://github.com/camping/mab).

## Installation

Add to Gemfile:

```ruby
gem 'rhb'
```

## Usage

Example:
```ruby
builder = Rhb::Builder.new

builder.doctype
builder.html do
  head do
    title 'Awesome page'
    link rel: 'stylesheet', href: 'style.css'
  end
  body id: :body do
    h1 'My Awesome Page', class: 'awesome', data: { awesomeness: { level: 'high' } }
    end
  end
end

builder.to_html
```

Result:
```html
<!DOCTYPE html><html><head><title>Awesome page</title><link rel="stylesheet" href="style.css"></head><body id="body"><h1 class="awesome" data-awesomeness-level="high">My Awesome Page</h1></body></html>
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
