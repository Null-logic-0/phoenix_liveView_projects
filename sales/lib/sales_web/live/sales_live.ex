defmodule SalesWeb.SalesLive do
  use SalesWeb, :live_view
  alias Sales.Sales

  def mount(_params, _session, socket) do
    if connected?(socket) do
      :timer.send_interval(3000, self(), :tick)
    end

    {:ok, sales_stats(socket)}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
    <h1 class="text-center font-bold text-3xl">Sales Dashboard 📊</h1>
    <div id="sales">
      <div class="stats">
        <div class="stat">
          <span class="value">
            <%= @new_orders %>
          </span>
          <span class="label">
            New Orders
          </span>
        </div>
        <div class="stat">
          <span class="value">
            $<%= @sales_amount %>
          </span>
          <span class="label">
            Sales Amount
          </span>
        </div>
        <div class="stat">
          <span class="value">
            <%= @satisfaction %>%
          </span>
          <span class="label">
            Satisfaction
          </span>
        </div>
      </div>

      <button phx-click="refresh" class="cursor-pointer">
         Refresh
      </button>
    </div>
    </Layouts.app>
    """
  end

  def handle_event("refresh", _, socket) do
    {:noreply, sales_stats(socket)}
  end

  def handle_info(:tick, socket) do
    {:noreply, sales_stats(socket)}
  end

  defp sales_stats(socket) do
    assign(socket,
      new_orders: Sales.new_orders(),
      sales_amount: Sales.sales_amount(),
      satisfaction: Sales.satisfaction()
    )
  end
end
