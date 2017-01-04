defmodule Sched.TokenController do
  use Sched.Web, :controller

  plug Addict.Plugs.Authenticated when action in [:authorize]

  alias Sched.Token

  def authorize(conn, _params) do

    ExTwitter.configure([
      consumer_key: "",
      consumer_secret: "",
      access_token: "",
      access_token_secret: ""
    ])

    token = ExTwitter.request_token("https://simplescheduler.herokuapp.com/verify_user")

    {:ok, authorize_url} = ExTwitter.authorize_url(token.oauth_token)

    # Copy the url, paste it in your browser and authenticate
    IO.puts authorize_url
    redirect conn, external: authorize_url

    #redirect(conn, to: scheduler_path(conn, :index))
  end

  def verify_user(conn, params) do
    oauth_token = params["oauth_token"]
    oauth_verifier = params["oauth_verifier"]

    {:ok, access_token} = ExTwitter.access_token(oauth_verifier, oauth_token)
    user_id = Addict.Helper.current_user(conn).id

    changeset = Token.changeset(%Token{}, %{access_tok: access_token.oauth_token, access_secret: access_token.oauth_token_secret, user_id: user_id})
    Sched.Repo.insert(changeset)

    redirect(conn, to: scheduler_path(conn, :index))

  end

end
