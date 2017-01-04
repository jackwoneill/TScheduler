defmodule Sched.ScheduleHelper do
	import Ecto.Query

	def check_for_items do
		IO.puts("Checking for new posts")
		curr_time = Timex.to_gregorian_seconds(Timex.now("America/New_York")) - 62167219200 + 1

		query = from t in Sched.Scheduler, [where: t.time <= ^curr_time and t.posted == false] 
		posts = Sched.Repo.all(query)

		for post <- posts, do: post_tweet(post)
	end

	defp post_tweet(post) do
		#MAKE THIS USER SPECIFIC BY PASSING USER ID THEN DOING A LOOKUP FOR AUTH TOKENS

		token = Sched.Repo.one(from token in Sched.Token, where: token.user_id == ^post.user_id)

	  	#CONFIGURE CLIENT
	  	ExTwitter.configure([
	    	consumer_key: "ZSx6f74ec908qp3S7dJ18iPfL",
	    	consumer_secret: "hViG3elQampdPzT3G0Q3HOSpsOgbSFfVRwTE7LvH35OEUw0vlL",
	    	access_token: token.access_tok,
	    	access_token_secret: token.access_secret
	  	])

	  	IO.puts("Posting " <> post.text)
	  	ExTwitter.update(post.text)

	  	post = Ecto.Changeset.change post, posted: true
	  	case Sched.Repo.update post do
	  	  {:ok, struct}       -> IO.puts("Successfully updated")
	  	  {:error, changeset} -> IO.puts("This did not work")
	  	end
	end
end
