defmodule Quine.Mixfile do
  use Mix.Project

  def project do
    [app: :quine,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: (Mix.env == :dev && [:exsync] || []) ++ [:logger, :maru]]
  end

  defp deps do
    [{:maru, "~> 0.11"},
     {:earmark, "~> 1.0"},
     {:exsync, "~> 0.1", only: :dev}]
  end
end
