defmodule Sched.Repo.Migrations.AddUserToPosts do
  use Ecto.Migration

  def change do
  	alter table(:schedulers) do
  		add :user_id, references(:users)
  	end
  end
end
