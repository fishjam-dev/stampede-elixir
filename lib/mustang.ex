defmodule Mustang do
  @moduledoc """
  A single browser user with behaviors
  """

  @callback run(Playwright.Browser.t()) :: any()
  @callback beforeJoin(Playwright.Browser.t()) :: any()
  @callback join(Playwright.Browser.t()) :: any()
  @callback afterJoin(Playwright.Browser.t()) :: any()
  @callback linger(Playwright.Browser.t()) :: any()
  @callback beforeLeave(Playwright.Browser.t()) :: any()
  @callback leave(Playwright.Browser.t()) :: any()
  @callback afterLeave(Playwright.Browser.t()) :: any()

  defmacro __using__(_opts) do
    quote location: :keep do
      @behaviour Mustang

      @impl true
      def run(browser) do
        browser
        |> beforeJoin()
        |> join()
        |> afterJoin()
        |> linger()
        |> beforeLeave()
        |> leave()
        |> afterLeave()
      end

      @impl true
      def beforeJoin(browser) do
        browser
      end

      @impl true
      def join(browser) do
        browser
      end

      @impl true
      def afterJoin(browser) do
        browser
      end

      @impl true
      def linger(browser) do
        browser
      end

      @impl true
      def beforeLeave(browser) do
        browser
      end

      @impl true
      def leave(browser) do
        browser
      end

      @impl true
      def afterLeave(browser) do
        browser
      end

      defoverridable run: 1
      defoverridable beforeJoin: 1
      defoverridable join: 1
      defoverridable afterJoin: 1
      defoverridable linger: 1
      defoverridable beforeLeave: 1
      defoverridable leave: 1
      defoverridable afterLeave: 1
    end
  end
end
