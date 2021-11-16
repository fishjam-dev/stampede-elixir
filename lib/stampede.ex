defmodule Stampede do
  def start({mustang_module, mustang_options}) do
    launch_browser() |> mustang_module.run(mustang_options)
  end

  def start({mustang_module, mustang_options}, options) do
    browser = launch_browser(options)

    if options.count do
      tasks =
        Enum.map(1..options.count, fn _x ->
          Task.async(fn -> mustang_module.run(browser, mustang_options) end)
        end)

      Task.await_many(tasks, :infinity)
    else
      mustang_module.run(browser, mustang_options)
    end
  end

  def launch_browser(options \\ %{}) do
    default_browser_args = [
      "--use-fake-device-for-media-stream",
      "--use-fake-ui-for-media-stream"
    ]

    additional_args = Map.get(options, :args, [])

    launch_options = %{
      args: default_browser_args ++ additional_args,
      headless: Map.get(options, :headless, true)
    }

    Application.put_env(:playwright, LaunchOptions, launch_options)

    {:ok, _} = Application.ensure_all_started(:playwright)

    {_connection, browser} = Playwright.BrowserType.launch()
    browser
  end
end
