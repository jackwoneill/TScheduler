defmodule Sched.SchedulerControllerTest do
  use Sched.ConnCase

  alias Sched.Scheduler
  @valid_attrs %{text: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, scheduler_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing schedulers"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, scheduler_path(conn, :new)
    assert html_response(conn, 200) =~ "New scheduler"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, scheduler_path(conn, :create), scheduler: @valid_attrs
    assert redirected_to(conn) == scheduler_path(conn, :index)
    assert Repo.get_by(Scheduler, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, scheduler_path(conn, :create), scheduler: @invalid_attrs
    assert html_response(conn, 200) =~ "New scheduler"
  end

  test "shows chosen resource", %{conn: conn} do
    scheduler = Repo.insert! %Scheduler{}
    conn = get conn, scheduler_path(conn, :show, scheduler)
    assert html_response(conn, 200) =~ "Show scheduler"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, scheduler_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    scheduler = Repo.insert! %Scheduler{}
    conn = get conn, scheduler_path(conn, :edit, scheduler)
    assert html_response(conn, 200) =~ "Edit scheduler"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    scheduler = Repo.insert! %Scheduler{}
    conn = put conn, scheduler_path(conn, :update, scheduler), scheduler: @valid_attrs
    assert redirected_to(conn) == scheduler_path(conn, :show, scheduler)
    assert Repo.get_by(Scheduler, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    scheduler = Repo.insert! %Scheduler{}
    conn = put conn, scheduler_path(conn, :update, scheduler), scheduler: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit scheduler"
  end

  test "deletes chosen resource", %{conn: conn} do
    scheduler = Repo.insert! %Scheduler{}
    conn = delete conn, scheduler_path(conn, :delete, scheduler)
    assert redirected_to(conn) == scheduler_path(conn, :index)
    refute Repo.get(Scheduler, scheduler.id)
  end
end
