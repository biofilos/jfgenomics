defmodule Jfgenomics.Education do
  @moduledoc """
  The degrees shown on the Education page.

  Each entry is a map with atom keys: `:title` (degree), `:school`,
  `:area` (field of study), and `:pub_link`. The representative
  publication citation is not duplicated here — it is derived from
  `Jfgenomics.Publications` via `:pub_link` (see `list/0`).
  """

  @behaviour Jfgenomics.Content

  alias Jfgenomics.Publications

  @degrees [
    %{
      title: "Doctor of Philosophy",
      school: "Vanderbilt University",
      area: "Biological Sciences",
      pub_link: "https://academic.oup.com/mbe/article/34/1/215/2655122"
    },
    %{
      title: "Master of Science",
      school: "University of Wyoming",
      area: "Molecular Biology",
      pub_link: "https://doi.org/10.1093/gbe/evt026"
    },
    %{
      title: "Bachelor of Science",
      school: "Universidad Nacional de Colombia",
      area: "Biology",
      pub_link: "https://doi.org/10.18475/cjos.v46i2.a19"
    }
  ]

  @doc """
  Returns the list of degrees, each enriched with a `:publication`
  citation string looked up from `Jfgenomics.Publications` (`nil` when
  the `:pub_link` does not match any known publication).
  """
  @impl true
  def list do
    Enum.map(@degrees, fn degree ->
      publication =
        case Publications.get_by_link(degree.pub_link) do
          nil -> nil
          pub -> Publications.citation(pub)
        end

      Map.put(degree, :publication, publication)
    end)
  end
end
