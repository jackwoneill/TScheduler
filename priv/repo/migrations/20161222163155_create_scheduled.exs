defmodule Sched.Repo.Migrations.CreateScheduled do
  use Ecto.Migration

  def change do
    create table(:scheduleds) do

      timestamps()
    end

  end
end
