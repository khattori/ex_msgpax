defmodule ExMsgpax.MixProject do
  use Mix.Project

  @description """
  ExMsgpax is a library for packing and unpacking Elixir data structures using MessagePack format.
  It provides support for various Elixir types, including tuples, structs, and exceptions,
  by utilizing MessagePack's extension types.
  """
  def project do
    [
      app: :ex_msgpax,
      description: @description,
      name: "ExMsgpax",
      version: "0.2.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      package: package(),
      versioning: versioning()
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
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:msgpax, "~> 2.4"},
      {:ex_const, "~> 0.3.0"},
      {:excoveralls, "~> 0.18.5", only: :test},
      {:ex_doc, "~> 0.40.1", only: :dev, runtime: false},
      {:mix_version, "~> 2.4", only: [:dev, :test], runtime: false},
    ]
  end

  defp package do
    [
      maintainers: ["hattori"],
      licenses: ["MIT"],
      links: %{ "Github" => "https://github.com/khattori/ex_msgpax" }
    ]
  end


  defp versioning do
    [
      annotate:   true,
      annotation: "new version %s",
      commit_msg: "new version %s",
      tag_prefix: "v"
    ]
  end
end
