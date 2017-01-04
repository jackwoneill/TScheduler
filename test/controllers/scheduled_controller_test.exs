defmodule Sched.ScheduledControllerTest do
  use Sched.ConnCase

  alias Sched.Scheduled
  @valid_attrs %{}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, scheduled_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing scheduleds"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, scheduled_path(conn, :new)
    assert html_response(conn, 200) =~ "New scheduled"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, scheduled_path(conn, :create), scheduled: @valid_attrs
    assert redirected_to(conn) == scheduled_path(conn, :index)
    assert Repo.get_by(Scheduled, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, scheduled_path(conn, :create), scheduled: @invalid_attrs
    assert html_response(conn, 200) =~ "New scheduled"
  end

  test "shows chosen resource", %{conn: conn} do
    scheduled = Repo.insert! %Scheduled{}
    conn = get conn, scheduled_path(conn, :show, scheduled)
    assert html_response(conn, 200) =~ "Show scheduled"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, scheduled_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    scheduled = Repo.insert! %Scheduled{}
    conn = get conn, scheduled_path(conn, :edit, scheduled)
    assert html_response(conn, 200) =~ "Edit scheduled"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    scheduled = Repo.insert! %Scheduled{}
    conn = put conn, scheduled_path(conn, :update, scheduled), scheduled: @valid_attrs
    assert redirected_to(conn) == scheduled_path(conn, :show, scheduled)
    assert Repo.get_by(Scheduled, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    scheduled = Repo.insert! %Scheduled{}
    conn = put conn, scheduled_path(conn, :update, scheduled), scheduled: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit scheduled"
  end

  test "deletes chosen resource", %{conn: conn} do
    scheduled = Repo.insert! %Scheduled{}
    conn = delete conn, scheduled_path(conn, :delete, scheduled)
    assert redirected_to(conn) == scheduled_path(conn, :index)
    refute Repo.get(Scheduled, scheduled.id)
  end
end
