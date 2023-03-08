defmodule LiveViewStudioWeb.LightLive do
  use LiveViewStudioWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, brightness: 10)}
  end

  def render(assigns) do
    ~H"""
    <h1>Front Porch Light</h1>
    <div id="light">
      <div class="meter">
        <span style={"width: #{@brightness}%"}>
          <%= @brightness %>%
        </span>
      </div>
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
    </div>
    """
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
end
