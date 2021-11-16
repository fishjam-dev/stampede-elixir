defmodule Stampede do
  def start({mustang_module, mustang_options}) do
    launch_browser() |> mustang_module.run(mustang_options)
  end

  def start({mustang_module, mustang_options}, %{count: count} = _options) do
    browser = launch_browser()

    tasks =
      Enum.map(1..count, fn _x ->
        Task.async(fn -> mustang_module.run(browser, mustang_options) end)
      end)

    Task.await_many(tasks, :infinity)
  end

  def launch_browser() do
    launch_options = %{
      args: [
        "--use-fake-device-for-media-stream",
        "--use-fake-ui-for-media-stream",
        "--enable-logging",
        "--force-fieldtrials=WebRTC-Audio-Red-For-Opus/Disabled/"
      ],
      headless: false
    }

    Application.put_env(:playwright, LaunchOptions, launch_options)

    {:ok, _} = Application.ensure_all_started(:playwright)

    {_connection, browser} = Playwright.BrowserType.launch()
    browser
  end
end
