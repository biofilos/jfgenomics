defmodule Jfgenomics.Content do
  @moduledoc """
  Single entry point for the site's hardcoded content.

  The data itself lives in section modules (`Awards`, `Courses`,
  `Education`, `Experience`, `Publications`, `Skills`); this module
  defines the shared contract and exposes one accessor per section.

  The blog is intentionally not part of this facade: posts carry
  rendering metadata (templates, tags, dates) that the CV-style
  sections don't, so they stay in `Jfgenomics.Blog`.
  """

  @doc """
  Section modules return a list of maps with atom keys. Each section
  documents its own keys in its `@moduledoc`.
  """
  @callback list() :: [map()]

  defdelegate awards(), to: Jfgenomics.Awards, as: :list
  defdelegate courses(), to: Jfgenomics.Courses, as: :list
  defdelegate education(), to: Jfgenomics.Education, as: :list
  defdelegate experience(), to: Jfgenomics.Experience, as: :list
  defdelegate publications(), to: Jfgenomics.Publications, as: :list
  defdelegate skills(), to: Jfgenomics.Skills, as: :list
end
