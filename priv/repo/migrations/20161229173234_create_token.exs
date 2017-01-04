defmodule Sched.Repo.Migrations.CreateToken do
  use Ecto.Migration

  def change do
    create table(:tokens) do
      add :access_tok, :string
      add :access_secret, :string
      add :user_id, :integer

      timestamps()
    end

  end
end
