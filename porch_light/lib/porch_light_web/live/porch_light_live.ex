defmodule PorchLightWeb.PorchLightLive do
  use PorchLightWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, brightness: 10)}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
    <h1 class="text-center text-2xl font-bold ">Porch light</h1>
    <div id="light">
      <div class="meter">
        <span style={"width: #{@brightness}%"}>
          {@brightness}%
        </span>
      </div>
      <button phx-click="down">
        🔽
      </button>
      <button phx-click="off">
        🔅
      </button>
      <button phx-click="on">
        🔆
      </button>
      <button phx-click="up">
        🔼
      </button>
      <button phx-click="fire">
       🔥
      </button>
    </div>
    </Layouts.app>
    """
  end

  def handle_event("on", _, socket), do: {:noreply, assign(socket, brightness: 100)}

  def handle_event("off", _, socket), do: {:noreply, assign(socket, brightness: 0)}

  def handle_event("down", _, socket),
    do: {:noreply, update(socket, :brightness, &max(&1 - 10, 0))}

  def handle_event("up", _, socket),
    do: {:noreply, update(socket, :brightness, &min(&1 + 10, 100))}

  def handle_event("fire", _, socket),
    do: {:noreply, assign(socket, brightness: Enum.random(0..100))}
end
