defmodule Sched.TokenTest do
  use Sched.ModelCase

  alias Sched.Token

  @valid_attrs %{access_secret: "some content", access_tok: "some content", user_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Token.changeset(%Token{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Token.changeset(%Token{}, @invalid_attrs)
    refute changeset.valid?
  end
end
