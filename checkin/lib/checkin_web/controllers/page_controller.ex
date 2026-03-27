defmodule CheckinWeb.PageController do
  use CheckinWeb, :controller

  def home(conn, _params) do
    redirect(conn, to: ~p"/volunteers")
  end
end
