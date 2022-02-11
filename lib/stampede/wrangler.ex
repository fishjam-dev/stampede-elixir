defmodule Stampede.Wrangler do
  @moduledoc """
  A non-blocking manager of async mustangs.
  """
  use GenServer

  def start(mustang_module, mustang_options, spawn_options) do
    GenServer.start(__MODULE__, {mustang_module, mustang_options, spawn_options})
  end

  def start_link(mustang_module, mustang_options, spawn_options) do
    GenServer.start_link(__MODULE__, {mustang_module, mustang_options, spawn_options})
  end

  @impl GenServer
  def init({mustang_module, mustang_options, spawn_options}) do
    browser = Stampede.launch_browser()

    {pid, ref} =
      Process.spawn(
        fn ->
          Stampede.run_mustang(browser, mustang_module, mustang_options, spawn_options)
        end,
        [:monitor]
      )

    {:ok, %{browser: browser, mustang_pid: pid, mustang_ref: ref}}
  end

  @impl GenServer
  def terminate(_reason, state) do
    if Process.alive?(state.mustang_pid),
      do: Process.exit(state.mustang_pid, :kill)

    Playwright.Browser.close(state.browser)
    :ok
  end

  @impl GenServer
  def handle_info(
        {:DOWN, _ref, :process, mustang_pid, reason},
        %{mustang_pid: mustang_pid} = state
      ) do
    Playwright.Browser.close(state.browser)
    {:stop, reason, state}
  end
end
