defmodule Stampede.MixProject do
  use Mix.Project

  def project do
    [
      app: :stampede,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
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
      {:playwright, github: "jellyfish-dev/playwright-elixir"},
      {:elixir_uuid, "~> 1.2.1"},
      {:ex_doc, "0.25.4", only: :dev, runtime: false}
    ]
  end
end
