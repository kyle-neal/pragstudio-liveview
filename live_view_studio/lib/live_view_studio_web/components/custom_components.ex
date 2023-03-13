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
  attr :class, :string, default: nil
  # For global HTML elements, such as phx-click="remove"
  attr :rest, :global

  def badge(assigns) do
    ~H"""
    <span class={["inline-flex items-center gap-0.5 rounded-full
             bg-gray-300 px-3 py-0.5 text-sm font-medium
             text-gray-800 hover:cursor-pointer", @class]} {@rest}>
      <%= @label %>
      <Heroicons.x_mark class="h-3 w-3 text-gray-600" />
    </span>
    """
  end

  attr :visible, :boolean, required: true
  attr :class, :string, default: nil

  def loading_dots(assigns) do
    ~H"""
    <div :if={@loading} class={@class}>Loading...</div>
    """
  end

  attr :visible, :boolean, required: true
  attr :class, :string, default: nil

  def loading_spinner(assigns) do
    ~H"""
    <div :if={@visible} class="flex justify-center my-10 relative">
      <div class="w-12 h-12 rounded-full absolute border-8 border-gray-300">
      </div>
      <div class="w-12 h-12 rounded-full absolute border-8 border-indigo-400 border-t-transparent animate-spin">
      </div>
    </div>
    """
  end
end
