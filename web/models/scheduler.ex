defmodule Sched.Scheduler do
  use Sched.Web, :model

  schema "schedulers" do
    field :text, :string
    field :temp_time, Ecto.DateTime, virtual: true
    field :time, :integer
    field :posted, :boolean
    belongs_to :user, Sched.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:text, :temp_time, :time, :posted, :user_id])
    |> validate_required([:text, :temp_time])
    |> put_change(:posted, false)
    |> datetime_to_seconds()
  end

  defp datetime_to_seconds(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{temp_time: time_datetime}} ->
        timezone = Timex.Timezone.get("America/New_York", Timex.now)
        time_datetime = Ecto.DateTime.to_erl(time_datetime)
        time_datetime = Timex.Timezone.convert(time_datetime, timezone)
        put_change(changeset, :time, (Timex.to_gregorian_seconds(time_datetime) - 62167219200))
      _ ->
        changeset
    end
  end
end
