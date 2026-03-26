defmodule SalesWeb.PageController do
  use SalesWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
