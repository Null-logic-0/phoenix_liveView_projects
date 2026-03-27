defmodule DonationsWeb.PageController do
  use DonationsWeb, :controller

  def home(conn, _params) do
    redirect(conn, to: ~p"/donations")
  end
end
