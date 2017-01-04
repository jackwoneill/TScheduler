defmodule Sched.Token do
  use Sched.Web, :model

  schema "tokens" do
    field :access_tok, :string
    field :access_secret, :string
    field :user_id, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:access_tok, :access_secret, :user_id])
    |> validate_required([:access_tok, :access_secret, :user_id])
  end
end
