defmodule Mix.Tasks.Stampede.Setup do
  @moduledoc """
  Sets up stampede for running load tests

  ```bash
  $ mix stampede.setup
  ```
  """

  @shortdoc "Sets up Stampede for running load tests by installing browsers via Playwright"
  use Mix.Task

  @impl true
  def run(_args) do
    Playwright.CLI.install_browsers()
  end
end
