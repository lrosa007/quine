use Mix.Config

config :maru, Quine,
  http: [port: System.get_env["PORT"] || 8000]
