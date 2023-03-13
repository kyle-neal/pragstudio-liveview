defmodule LiveViewStudioWeb.VehiclesLive do
  use LiveViewStudioWeb, :live_view

  import LiveViewStudioWeb.CustomComponents
  alias LiveViewStudio.Vehicles

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        vehicles: [],
        vehicle: "",
        loading: false,
        matches: %{}
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>🚙 Find a Vehicle 🚘</h1>
    <div id="vehicles">
      <form phx-submit="search" phx-change="suggest">
        <input
          type="text"
          name="query"
          value={@vehicle}
          placeholder="Make or model"
          autofocus
          autocomplete="off"
          readonly={@loading}
          phx-debounce="500"
          list="matches"
        />

        <button>
          <img src="/images/search.svg" />
        </button>
        <datalist
          id="matches"
          class="datalist scrollable"
          style="overflow-y: auto!important"
        >
          <option :for={suggestion <- @matches} value={suggestion}>
            <%= suggestion %>
          </option>
        </datalist>
      </form>

      <.loading_spinner visible={@loading} />

      <div class="vehicles">
        <ul>
          <li :for={vehicle <- @vehicles}>
            <span class="make-model">
              <%= vehicle.make_model %>
            </span>
            <span class="color">
              <%= vehicle.color %>
            </span>
            <span class={"status #{vehicle.status}"}>
              <%= vehicle.status %>
            </span>
          </li>
        </ul>
      </div>
    </div>
    """
  end

  def handle_info({:query, query}, socket) do
    {:noreply,
     assign(socket,
       vehicles: Vehicles.search(query),
       vehicle: query,
       loading: false
     )}
  end

  def handle_event("suggest", %{"query" => prefix}, socket) do
    {:noreply, assign(socket, matches: Vehicles.suggest(prefix))}
  end

  def handle_event("search", %{"query" => query}, socket) do
    send(self(), {:query, query})

    {:noreply,
     assign(socket,
       vehicle: query,
       loading: true
     )}
  end
end
