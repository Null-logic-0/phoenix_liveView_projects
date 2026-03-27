defmodule LiveNavWeb.PageController do
  use LiveNavWeb, :controller

  def home(conn, _params) do
    redirect(conn, to: ~p"/servers")
  end
end
