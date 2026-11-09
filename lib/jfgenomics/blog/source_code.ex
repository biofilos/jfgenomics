defmodule Jfgenomics.Blog.SourceCode do
  @moduledoc """
  Fetches remote source code shown in blog posts (e.g. raw files from
  GitHub) server-side, so the code is part of the rendered HTML instead
  of being loaded in the browser.

  Successful responses are cached in `:persistent_term`, so each URL is
  fetched at most once per VM boot. Failures are not cached: the next
  render retries the fetch.

  Fetching can be disabled per environment (e.g. in tests) with:

      config :jfgenomics, Jfgenomics.Blog.SourceCode, enabled: false
  """

  @enabled Application.compile_env(:jfgenomics, [__MODULE__, :enabled], true)

  @doc """
  Returns `{:ok, source}` for the given raw URL, or `{:error, reason}`
  when the file could not be fetched.
  """
  def fetch(url) do
    if @enabled do
      case :persistent_term.get({__MODULE__, url}, :miss) do
        :miss -> fetch_and_cache(url)
        {:ok, _source} = cached -> cached
      end
    else
      {:error, :fetching_disabled}
    end
  end

  defp fetch_and_cache(url) do
    case Req.get(url, receive_timeout: 5_000, retry: false) do
      {:ok, %{status: 200, body: body}} when is_binary(body) ->
        result = {:ok, body}
        :persistent_term.put({__MODULE__, url}, result)
        result

      {:ok, %{status: status}} ->
        {:error, {:http_error, status}}

      {:error, reason} ->
        {:error, reason}
    end
  end
end
