defmodule LiveViewStudioWeb.CustomComponents do
  use Phoenix.Component

  # Make icons in live_view_studio_web/components/icons/ directory available as function components
  embed_templates "icons/*"

  # Attributes for icons
  attr :spinning, :boolean, default: false
  def moon_icon(assigns)

  attr :points, :integer, required: true
  def star_icon(assigns)

  attr :label, :string, required: true

  def badge(assigns) do
    ~H"""
    <span class="inline-flex items-center gap-0.5 rounded-full
             bg-gray-300 px-3 py-0.5 text-sm font-medium
             text-gray-800 hover:cursor-pointer">
      <%= @label %>
      <Heroicons.x_mark class="h-3 w-3 text-gray-600" />
    </span>
    """
  end
end
