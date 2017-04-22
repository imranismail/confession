defmodule Confession.ViewHelpers do
  alias Confession.Naming

  def render_one(resource, view, template, opts \\ []) do
    as = resource_name(view, opts)
    render(view, template, as, resource)
  end

  def render_many(resources, view, template, opts \\ []) do
    as = resource_name(view, opts)
    for resource <- resources, do: render(view, template, as, resource)
  end

  defp render(view, template, as, resource) do
    assigns = Map.put(%{}, as, resource)
    view.render(template, assigns)
  end

  defp resource_name(view, opts) do
    Keyword.get(opts, :as, fn ->
      Naming.resource_name(view, "View")
    end)
  end
end
