defmodule Sched.Repo.Migrations.AddDateTimeToSchedulers do
  use Ecto.Migration

  def change do
  	alter table(:schedulers) do
  		add :time, :integer
  	end
  end
end
