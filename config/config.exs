use Mix.Config

config :maru, Quine,
  http: [port: System.get_env["PORT"] || 8000]

config :quine,
  api_url: System.get_env["APP_URL"] || "http://localhost:8000"
