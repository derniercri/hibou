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


```
http://localhost:4000/authorize?scope=read,write&client_id=1&redirect_uri=http://localhost:3000&response_type=code
```

__config.exs__

```elixir

config :hibou,
  repo: HibouExample.Repo,
  guardian: HibouExample.Guardian
  
config :hibou_example, HibouExample.AuthAccessPipeline,
  module: HibouExample.Guardian,
  error_handler: HibouExample.AuthErrorHandler
```

__router.ex__

```elixir
defmodule HibouWeb.Router do
  use HibouWeb, :router

  pipeline :browser do
    ...
    plug(HibouExample.AuthAccessPipeline)
  end

  ...

  scope "/", HibouExampleWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/authorize", AuthorizationController, :new)
    post("/authorize", AuthorizationController, :create)
    resources("/registrations", RegistrationController, only: [:new, :create])
    get("/login", SessionController, :new)
    post("/login", SessionController, :create)
    delete("/logout", SessionController, :delete)
  end

  # Other scopes may use custom stacks.
  scope "/v1", HibouExampleWeb do
    pipe_through(:api)

    post("/auth/tokens", AuthorizationController, :create)
  end
end
```

## Development

__Getting started__

```
docker-compose up -d
mix deps.get
mix ecto.reset
mix phx.server
```
