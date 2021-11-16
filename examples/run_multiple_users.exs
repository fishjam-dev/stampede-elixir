defmodule ExampleMustang do
  use Stampede.Mustang

  @impl true
  def join(browser, options) do
    page = browser |> Playwright.Browser.new_page()

    page |> Playwright.Page.goto(options.target_url)
  end

  @impl true
  def linger(_browser, _options) do
    :timer.sleep(:timer.seconds(5))
  end
end

mustang_options = %{ target_url: "https://google.com" }
options = %{ count: 3 }

Stampede.start({ExampleMustang, mustang_options}, options)
