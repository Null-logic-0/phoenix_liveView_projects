defmodule FlightsWeb.FlightsLive do
  use FlightsWeb, :live_view
  alias Flights.Flights
  alias Flights.Airports

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        airport: "",
        flights: [],
        loading: false,
        matches: %{}
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
    <h1 class="text-center font-bold text-3xl">Find a Flight</h1>
    <div id="flights">
      <form phx-submit="search" phx-change="suggest">
        <input
          type="text"
          name="airport"
          value={@airport}
          placeholder="Airport Code"
          autofocus
          autocomplete="off"
          readonly={@loading}
          list="matches"
          phx-debounce="500"
        />

        <button class="cursor-pointer">
          <.icon name="hero-magnifying-glass" class="size-4"/>
        </button>
      </form>

      <datalist id="matches">
        <option :for={{code,name}<-@matches} value={code}>
          <%=name%>
        </option>
      </datalist>

      <div :if={@loading} class="loading loading-ring loading-xl block mx-auto mt-12">Loading...</div>
      <div class="flights">
        <ul>
            <li :for={flight <- @flights}>
              <div class="first-line">
                <div class="number">
                  Flight #<%= flight.number %>
                </div>
                <div class="origin-destination">
                  <%= flight.origin %> to <%= flight.destination %>
                </div>
              </div>
              <div class="second-line">
                <div class="departs">
                  Departs: <%= flight.departure_time %>
                </div>
                <div class="arrives">
                  Arrives: <%= flight.arrival_time %>
                </div>
              </div>
            </li>
        </ul>
      </div>
    </div>
    </Layouts.app>
    """
  end

  def handle_event("suggest", %{"airport" => prefix}, socket) do
    matches = Airports.suggest(prefix)
    {:noreply, assign(socket, matches: matches)}
  end

  def handle_event("search", %{"airport" => airport}, socket) do
    send(self(), {:run_search, airport})

    socket =
      assign(socket,
        airport: airport,
        flights: [],
        loading: true
      )

    {:noreply, socket}
  end

  def handle_info({:run_search, airport}, socket) do
    socket =
      assign(
        socket,
        flights: Flights.search_by_airport(airport),
        loading: false
      )

    {:noreply, socket}
  end
end
