# Implementation plan: `Jfgenomics.Content`

Status: **implemented** (see `lib/jfgenomics/content.ex`). This document
is kept as a record of the design decisions.

## Goal

Unify the five near-identical content modules (`Awards`, `Courses`,
`Education`, `Experience`, `Publications`) behind a single
`Jfgenomics.Content` facade, so the site has one obvious place to look
for content and one convention for entry shapes. `Blog` stays separate:
posts have rendering metadata (templates, tags, dates) that the CV-style
sections don't.

## Proposed design

Keep the existing per-section modules as the **data sources**, and add a
thin facade that controllers call:

```elixir
defmodule Jfgenomics.Content do
  @moduledoc """
  Single entry point for the site's hardcoded content.

  The data itself lives in section modules (`Awards`, `Courses`,
  `Education`, `Experience`, `Publications`, `Skills`); this module
  defines the shared contract and exposes one accessor per section.
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
```

Then each section module opts into the contract with
`@behaviour Jfgenomics.Content`.

Controllers change from e.g. `Jfgenomics.Awards.list()` to
`Jfgenomics.Content.awards()` — templates and assigns are untouched.

### Why a facade instead of one big module or data files

| Option | Pros | Cons |
| --- | --- | --- |
| **Facade (proposed)** | One import in controllers; per-section docs stay next to data; zero template churn; trivial diff | Section modules still exist |
| Single `Content` module with all data inlined | One file to open | ~300-line module mixing unrelated content; worse merge conflicts |
| YAML/JSON under `priv/content/` loaded at compile time | Non-programmers can edit content | Needs a parser dep (YAML) or verbose JSON; build-time file watching plumbing; overkill for content edited a few times a year |

## Migration steps

1. Add `Jfgenomics.Content` with the `@callback` and `defdelegate`s.
2. Add `@behaviour Jfgenomics.Content` to the six section modules.
3. Update `JfgenomicsWeb.PageController` to call `Jfgenomics.Content.*`
   (one-line changes per action).
4. Update `AGENTS.md` with a one-liner: "site content lives in
   `lib/jfgenomics/*` modules behind the `Jfgenomics.Content` facade".
5. Run `mix precommit`.

Estimated diff: ~1 new file (~40 lines), 6 one-line behaviour
annotations, ~6 changed lines in the controller.

## Open questions for review

1. Should `Skills` join the facade too (it is part of the home page,
   like the other sections)? Proposed: yes, included above.
2. Keep per-section modules, or collapse each section into
   `@awards [...]`-style module attributes inside `Content`? Proposed:
   keep modules — the sections have section-specific helpers
   (`Publications.citation/1`, `Education`'s join with `Publications`)
   that read better next to their data.
3. Naming of accessors: `awards/0` (proposed) vs `list_awards/0`.
