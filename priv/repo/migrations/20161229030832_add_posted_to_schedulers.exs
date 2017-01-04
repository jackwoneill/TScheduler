defmodule Sched.Repo.Migrations.AddPostedToSchedulers do
  use Ecto.Migration

  def change do
  	alter table(:schedulers) do
  		add :posted, :boolean
  	end
  end
end
