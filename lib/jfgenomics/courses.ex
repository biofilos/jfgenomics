defmodule Jfgenomics.Courses do
  @moduledoc """
  The courses and workshops shown on the Education page.

  Each entry is a map with atom keys: `:name`, `:institution`,
  `:place`, `:duration` (human-readable range), and `:year`.
  """

  @behaviour Jfgenomics.Content

  @impl true
  def list do
    [
      %{
        name: "Introduction to concepts and methods of networks in evolutionary studies",
        institution: "Station Biologique de Roscoff",
        place: "France",
        duration: "July 3 - 9",
        year: 2016
      },
      %{
        name: "Tutorial on Evolutionary Quantitative Genetics",
        institution: "NIMBioS at the University of Tennessee, Knoxville",
        place: "USA",
        duration: "August 10 - 15",
        year: 2015
      },
      %{
        name: "Hands-on Workshop on computational biophysics at Pittsburgh",
        institution: "Pittsburgh supercomputing center. University of Pittsburgh",
        place: "USA",
        duration: "June 10 - 14",
        year: 2013
      },
      %{
        name: "Workshop on Molecular Evolution",
        institution: "Marine Biological Laboratory (MBL). Woods Hole MA",
        place: "USA",
        duration: "July 22 - August 1",
        year: 2012
      }
    ]
  end
end
