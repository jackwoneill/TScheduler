defmodule Sched.Repo.Migrations.CreateScheduler do
  use Ecto.Migration

  def change do
    create table(:schedulers) do
      add :text, :string

      timestamps()
    end

  end
end
