defmodule Sched.ScheduledTest do
  use Sched.ModelCase

  # alias Sched.Scheduled

  # @valid_attrs %{}
  # @invalid_attrs %{}

  # test "changeset with valid attributes" do
  #   changeset = Scheduled.changeset(%Scheduled{}, @valid_attrs)
  #   assert changeset.valid?
  # end

  # test "changeset with invalid attributes" do
  #   changeset = Scheduled.changeset(%Scheduled{}, @invalid_attrs)
  #   refute changeset.valid?
  # end
#end

  schema "scheduleds" do
    field :text, :string

   # has_many :portfolio_items, Panaya.PortfolioItem

    #has_many :portfolios, through: [:portfolio_items, :portfolio]

    #many_to_many :portfolios, Panaya.Portfolio, join_through: Panaya.PortfolioItem
    timestamps

  end

  
  @required_fields ~w(text)
  @optional_fields ~w()


  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(item, params \\ :invalid) do
    item
    |> cast(params, @required_fields, @optional_fields)
    #|> cast_assoc(:portfolio_items)
    |> validate_required([:text])
  end
end
