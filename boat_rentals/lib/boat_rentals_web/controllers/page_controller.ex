defmodule BoatRentalsWeb.PageController do
  use BoatRentalsWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
