defmodule Stampede.Mustang do
  @moduledoc """
  A single browser user with behaviors
  """

  @callback run(Playwright.Browser.t(), map()) :: any()
  @callback beforeJoin(Playwright.Browser.t(), map()) :: any()
  @callback join(Playwright.Browser.t(), map()) :: any()
  @callback afterJoin(Playwright.Browser.t(), map()) :: any()
  @callback linger(Playwright.Browser.t(), map()) :: any()
  @callback beforeLeave(Playwright.Browser.t(), map()) :: any()
  @callback leave(Playwright.Browser.t(), map()) :: any()
  @callback afterLeave(Playwright.Browser.t(), map()) :: any()

  defmacro __using__(_opts) do
    quote location: :keep do
      @behaviour Stampede.Mustang

      @impl true
      def run(browser, options) do
        browser
        |> beforeJoin(options)
        |> join(options)
        |> afterJoin(options)
        |> linger(options)
        |> beforeLeave(options)
        |> leave(options)
        |> afterLeave(options)
      end

      @impl true
      def beforeJoin(browser, options) do
        browser
      end

      @impl true
      def join(browser, options) do
        browser
      end

      @impl true
      def afterJoin(browser, options) do
        browser
      end

      @impl true
      def linger(browser, options) do
        browser
      end

      @impl true
      def beforeLeave(browser, options) do
        browser
      end

      @impl true
      def leave(browser, options) do
        browser
      end

      @impl true
      def afterLeave(browser, options) do
        browser
      end

      defoverridable run: 2
      defoverridable beforeJoin: 2
      defoverridable join: 2
      defoverridable afterJoin: 2
      defoverridable linger: 2
      defoverridable beforeLeave: 2
      defoverridable leave: 2
      defoverridable afterLeave: 2
    end
  end
end
