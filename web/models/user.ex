defmodule Sched.User do
  use Sched.Web, :model

  schema "users" do
    field :email, :string
    field :encrypted_password, :string
    has_many :schedulers, Sched.Scheduler # new line

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :encrypted_password])
    |> validate_required([:email, :encrypted_password])
  end
end
