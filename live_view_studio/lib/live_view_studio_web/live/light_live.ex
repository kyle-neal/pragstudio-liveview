defmodule LiveViewStudioWeb.LightLive do
  use LiveViewStudioWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, brightness: 10, temp: 3000)}
  end

  def render(assigns) do
    ~H"""
    <h1>Front Porch Light</h1>
    <div id="light">
      <div class="meter">
        <span style={"width: #{@brightness}%;background:#{temp_color(@temp)}"}>
          <%= @brightness %>%
        </span>
      </div>
      <h4>Temperature Adjustment</h4>
      <button phx-click="off">
        <img src="/images/light-off.svg" alt="" />
      </button>
      <button phx-click="down">
        <img src="/images/down.svg" alt="" />
      </button>
      <button phx-click="on">
        <img src="/images/light-on.svg" alt="" />
      </button>
      <button phx-click="up">
        <img src="/images/up.svg" alt="" />
      </button>
      <button phx-click="random">
        <img src="/images/fire.svg" alt="" />
      </button>
      <form phx-change="slider_adjusted">
        <input type="range" min="0" max="100" name="brightness" value="50" />
      </form>
      <form phx-change="temp_changed">
        <h4>Light Temperature</h4>
        <div class="temps">
          <%= for temp <- ["3000", "4000", "5000"] do %>
            <div>
              <input
                type="radio"
                id={temp}
                name="temp"
                value={temp}
                checked={temp == @temp}
              />
              <label for={temp}><%= temp %></label>
            </div>
          <% end %>
        </div>
      </form>
    </div>
    """
  end

  def handle_event("temp_changed", %{"temp" => temp} = _payload, socket) do
    {:noreply, assign(socket, temp: String.to_integer(temp))}
  end

  def handle_event("slider_adjusted", %{"brightness" => brightness} = _payload, socket) do
    {:noreply, assign(socket, brightness: String.to_integer(brightness))}
  end

  def handle_event("on", _payload, socket) do
    {:noreply, assign(socket, brightness: 100)}
  end

  def handle_event("off", _payload, socket) do
    {:noreply, assign(socket, brightness: 0)}
  end

  def handle_event("up", _payload, socket) do
    {:noreply, update(socket, :brightness, &min(&1 + 10, 100))}
  end

  def handle_event("down", _payload, socket) do
    {:noreply, update(socket, :brightness, &max(&1 - 10, 0))}
  end

  def handle_event("random", _payload, socket) do
    {:noreply, assign(socket, :brightness, :rand.uniform(100))}
  end

  defp temp_color(3000), do: "#F1C40D"
  defp temp_color(4000), do: "#FEFF66"
  defp temp_color(5000), do: "#99CCFF"
end
