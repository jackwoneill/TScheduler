defmodule Sched.SchedulerController do
  use Sched.Web, :controller

  plug Addict.Plugs.Authenticated when action in [:index, :new, :create, :update, :edit, :show, :delete]
  #plug :action

  alias Sched.Scheduler

  def index(conn, _params) do

    user = Addict.Helper.current_user(conn)

    count = Repo.all(from token in Sched.Token, where: token.user_id == ^user.id)

    IO.inspect count

    if length(count) == 0 do
      redirect(conn, to: token_path(conn, :authorize))
    end

    query = from t in Sched.Scheduler, [where: t.user_id == ^user.id]
    schedulers = Repo.all(query)

    render(conn, "index.html", schedulers: schedulers)

  end

  def new(conn, _params) do
    user = Addict.Helper.current_user(conn)

    changeset = Scheduler.changeset(%Scheduler{user_id: user.id})

    IO.inspect(changeset)

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"scheduler" => scheduler_params}) do
    user = Addict.Helper.current_user(conn)

    #CHANGE THIS, DONT NEED FIRST ASSIGN
    changeset = Scheduler.changeset(%Scheduler{user_id: user.id}, scheduler_params)

    case Repo.insert(changeset) do
      {:ok, _scheduler} ->
        conn
        |> put_flash(:info, "Scheduler created successfully.")
        |> redirect(to: scheduler_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    scheduler = Repo.get!(Scheduler, id)
    render(conn, "show.html", scheduler: scheduler)
  end

  def edit(conn, %{"id" => id}) do
    scheduler = Repo.get!(Scheduler, id)
    changeset = Scheduler.changeset(scheduler)
    render(conn, "edit.html", scheduler: scheduler, changeset: changeset)
  end

  def update(conn, %{"id" => id, "scheduler" => scheduler_params}) do
    scheduler = Repo.get!(Scheduler, id)
    changeset = Scheduler.changeset(scheduler, scheduler_params)

    case Repo.update(changeset) do
      {:ok, scheduler} ->
        conn
        |> put_flash(:info, "Scheduler updated successfully.")
        |> redirect(to: scheduler_path(conn, :show, scheduler))
      {:error, changeset} ->
        render(conn, "edit.html", scheduler: scheduler, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    scheduler = Repo.get!(Scheduler, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(scheduler)

    conn
    |> put_flash(:info, "Scheduler deleted successfully.")
    |> redirect(to: scheduler_path(conn, :index))
  end


end
