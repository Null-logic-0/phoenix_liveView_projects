defmodule PorchLightWeb.PageController do
  use PorchLightWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
