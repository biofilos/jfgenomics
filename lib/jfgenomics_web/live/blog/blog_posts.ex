defmodule JfgenomicsWeb.BlogPosts do
  @moduledoc """
  Embeds all blog post templates as function components.
  Each .html.heex file under blog_posts/ becomes a callable function.
  """
  use JfgenomicsWeb, :html

  import JfgenomicsWeb.BlogComponents

  embed_templates "blog_posts/*"
end
