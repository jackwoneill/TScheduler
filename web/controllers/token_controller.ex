defmodule Sched.TokenController do
  use Sched.Web, :controller

  plug Addict.Plugs.Authenticated when action in [:authorize]

  alias Sched.Token

  def authorize(conn, _params) do

    ExTwitter.configure([
      consumer_key: "ZSx6f74ec908qp3S7dJ18iPfL",
      consumer_secret: "hViG3elQampdPzT3G0Q3HOSpsOgbSFfVRwTE7LvH35OEUw0vlL",
      access_token: "868385953-akQdSyBLpmGKNNNdLCNHAN5uWOK68JaEwmWfhBni",
      access_token_secret: "uoIdVqz0JgLw2UTbmzhOpSe7v4WfQo88Uui9S9wNYrZh6"
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
