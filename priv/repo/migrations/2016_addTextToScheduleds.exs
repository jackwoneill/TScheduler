defmodule Sched.Repo.Migrations.AddTextToScheduleds do
  use Ecto.Migration

  def change do
  	alter table(:scheduleds) do
  		add :text, :string

  	end


  end
end
