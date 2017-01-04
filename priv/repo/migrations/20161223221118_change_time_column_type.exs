defmodule Sched.Repo.Migrations.ChangeTimeColumnType do
  use Ecto.Migration

  def change do
  	alter table(:schedulers) do
  		remove :time
  	end
  end
end
