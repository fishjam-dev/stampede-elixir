defmodule Stampede do
  @typedoc """
  Stampede runtime options

  * count - number of mustangs that will be spawned
  * delay - delay between subsequent spawns
  """
  @type options_t() :: %{
          count: pos_integer(),
          delay: :timer.time()
        }

  def start({mustang_module, mustang_options}) do
    launch_browser() |> mustang_module.run(mustang_options)
  end

  def start({mustang_module, mustang_options}, options) do
    browser = launch_browser(options)
    IO.inspect(options, label: :opts)

    if options.count do
      delay = Map.get(options, :delay, 0)

      tasks =
        Enum.map(1..options.count, fn _x ->
          task_ref = Task.async(fn -> mustang_module.run(browser, mustang_options) end)
          :timer.sleep(delay)
          task_ref
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
