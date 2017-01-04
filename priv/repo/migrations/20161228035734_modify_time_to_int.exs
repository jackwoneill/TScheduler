defmodule Sched.Repo.Migrations.ModifyTimeToInt do
  use Ecto.Migration

  def change do
  	alter table(:schedulers) do
  	  modify :time, :bigint
  	end
  end
end
