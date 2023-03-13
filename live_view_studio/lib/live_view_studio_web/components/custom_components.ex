defmodule LiveViewStudioWeb.CustomComponents do
  use Phoenix.Component

  # Make icons in live_view_studio_web/components/icons/ directory available as function components
  embed_templates "icons/*"

  # Attributes for icons
  attr :spinning, :boolean, default: false
  def moon_icon(assigns)

  attr :points, :integer, required: true
  def star_icon(assigns)

  # Attributes for promo function component
  attr :expiration, :integer, default: 24
  attr :minutes, :integer
  slot :legal
  slot :inner_block, required: true

  def promo(assigns) do
    assigns = assign_new(assigns, :minutes, fn -> assigns.expiration * 60 end)

    ~H"""
    <div class="promo">
      <div class="deal">
        <%= render_slot(@inner_block) %>
      </div>
      <div class="expiration">
        Deal expires in <%= @expiration %> HOURS AND <%= @minutes %> MINUTES
      </div>
      <div class="legal">
        <%= render_slot(@legal) %>
      </div>
    </div>
    """
  end

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
