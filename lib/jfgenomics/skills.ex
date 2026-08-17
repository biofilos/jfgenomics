defmodule Jfgenomics.Skills do
  @moduledoc """
  The skill sets shown in the "Development Skills" section of the home page.
  """

  @doc """
  Returns the list of skill categories.

  Each category is a map with `:area` (title), `:icon` (heroicon name for
  the category header) and `:skills` — a list of `%{name:, icon:}` maps
  where `:icon` is a devicon name (see `JfgenomicsWeb.Devicon`) or a
  `"hero-*"` heroicon name for tools without a devicon, plus an optional
  `:badge` (e.g. `"learning"`).
  """
  def list do
    [
      %{
        area: "Programming languages, OS",
        icon: "hero-command-line",
        skills: [
          %{name: "Python", icon: "python"},
          %{name: "Bash", icon: "bash"},
          %{name: "R", icon: "r"},
          %{name: "Rust", icon: "rust", badge: "learning"},
          %{name: "Elixir", icon: "elixir", badge: "learning"},
          %{name: "Linux", icon: "linux"}
        ]
      },
      %{
        area: "Web development",
        icon: "hero-globe-alt",
        skills: [
          %{name: "Django", icon: "django"},
          %{name: "Javascript", icon: "javascript"},
          %{name: "Svelte", icon: "svelte"},
          %{name: "Phoenix", icon: "phoenix"}
        ]
      },
      %{
        area: "Workflow Managers",
        icon: "hero-arrow-path",
        skills: [
          %{name: "Cromwell", icon: "hero-document-text"},
          %{name: "Nextflow", icon: "nextflow"}
        ]
      },
      %{
        area: "Cloud, DevOps",
        icon: "hero-cloud",
        skills: [
          %{name: "Git", icon: "git"},
          %{name: "Docker", icon: "docker"},
          %{name: "AWS", icon: "amazonwebservices"},
          %{name: "Google Cloud", icon: "googlecloud"}
        ]
      }
    ]
  end
end
