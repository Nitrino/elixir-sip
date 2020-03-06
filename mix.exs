defmodule Sip.MixProject do
  use Mix.Project

  def project do
    [
      app: :sip,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      compilers: [:rustler] ++ Mix.compilers(),
      rustler_crates: rustler_crates()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:rustler, "~> 0.22.0-rc.0"},
      {:nimble_parsec, "~> 0.5.3"}
    ]
  end

  defp rustler_crates do
    [
      sip_parser: [
        path: "native/sip_parser",
        mode: if(Mix.env() == :prod, do: :release, else: :debug)
      ]
    ]
  end
end
