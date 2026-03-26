defmodule FlightsWeb.PageController do
  use FlightsWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
