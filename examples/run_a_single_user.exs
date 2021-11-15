defmodule ExampleMustang do
  use Mustang

  @impl true
  def join(browser) do
    page = browser |> Playwright.Browser.new_page()

    page |> Playwright.Page.goto("https://google.com")
  end

  @impl true
  def linger(_browser) do
    :timer.sleep(:timer.seconds(5))
  end
end

Stampede.start(ExampleMustang)
