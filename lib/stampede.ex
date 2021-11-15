defmodule Stampede do
  def start(mustang_module) do
    launch_browser() |> mustang_module.run
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
