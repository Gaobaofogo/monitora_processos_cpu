defmodule ServerGraphqlWeb.PageController do
  use ServerGraphqlWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
