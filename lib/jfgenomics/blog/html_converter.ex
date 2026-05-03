defmodule Jfgenomics.Blog.HtmlConverter do
  def convert(_path, body, _attrs, _opts) do
    get_sources(body)
    |> Earmark.as_html!()
    |> NimblePublisher.Highlighter.highlight()
  end

  defp get_sources(body) do
    body
    |> String.split("\n")
    |> Enum.map(fn line ->
      case String.split(line, "=>") do
        [lang, url] ->
          {:ok, %Req.Response{:body => code}} = Req.get(url)

          """
          ```#{lang}
          #{code}
          ```
          """

        [line_original] ->
          line_original
      end
    end)
    |> Enum.join("\n")
  end
end
