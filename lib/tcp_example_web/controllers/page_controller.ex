defmodule TcpExampleWeb.PageController do
  use TcpExampleWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
