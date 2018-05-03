# Hibou

[![Build Status](https://travis-ci.org/derniercri/hibou.svg?branch=master)](https://travis-ci.org/derniercri/hibou)

<pre style="background-color:transparent">
  __________
 / ___  ___ \
/ / @ \/ @ \ \
\ \___/\___/ /\
 \____\/____/||
 /     /\\\\\//
 |     |\\\\\\
  \      \\\\\\
   \______/\\\\
    _||_||_
     -- --
</pre>


__Disclamer__

Hibou is in active development, do not try to use it in production.

Hibou is ready to use OAuth2 library built on top of [Guardian](https://github.com/ueberauth/guardian). It focus on simplicity and extensibility.

__Todo__

- Default client
- Default authorization page
- Send activation email
- JWT token support

## Development

__Getting started__

```
docker-compose up -d
mix deps.get
mix ecto.reset
mix phx.server
```