defmodule LiveViewStudioWeb.PromoComponents do
  use Phoenix.Component

  # Attributes for HEEX function components
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
end
