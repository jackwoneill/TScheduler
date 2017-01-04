defmodule Sched.PageController do
  use Sched.Web, :controller

  def index(conn, _params) do
    if Addict.Helper.is_logged_in(conn) == true do
      redirect(conn, to: scheduler_path(conn, :index))
    else
      render conn, "index.html"
    end
  end

end
