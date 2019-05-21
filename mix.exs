defmodule PriorityReceive.MixProject do
  use Mix.Project

  def project do
    [
      app: :priority_receive,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.19", only: :dev, runtime: false}
    ]
  end

  defp description() do
    "Prioritized selective receive for Elixir"
  end

  defp package() do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE", ".formatter.exs"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/farhadi/priority_receive"}
    ]
  end
end
