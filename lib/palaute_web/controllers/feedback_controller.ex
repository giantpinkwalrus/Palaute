defmodule PalauteWeb.FeedbackController do
  use PalauteWeb, :controller
  alias Palaute.{Feedback, Repo}

  def index(conn, %{"feedback" => feedback, "name" => name}) do
    feedback_changeset = Feedback.changeset(%Feedback{}, %{
      feedback: feedback,
      name: name
    })
    {ok, _} = Repo.insert(feedback_changeset)
    render conn, "index.html", good: ok == :ok
  end
end
