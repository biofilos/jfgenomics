defmodule Jfgenomics.Awards do
  @moduledoc """
  The awards and grants shown on the Education page.

  Each entry is a map with atom keys: `:name`, `:institution`, and
  `:time` (human-readable date or range).
  """

  @behaviour Jfgenomics.Content

  @impl true
  def list do
    [
      %{
        name: "Special Postdoctoral Researchers Program (SPDR)",
        institution: "RIKEN",
        time: "2020 - 2021"
      },
      %{
        name: "Young Investigator Travel Award",
        institution: "Society for Molecular Biology and Evolution (SMBE)",
        time: "2018"
      },
      %{
        name: "Travel Award",
        institution: "Quest for Orthologs 5 Conference",
        time: "2017"
      },
      %{
        name: "Best 3 Minutes Thesis Presentation",
        institution: "Department of Biological Sciences, Vanderbilt University",
        time: "2017"
      }
    ]
  end
end
