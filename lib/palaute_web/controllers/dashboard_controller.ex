defmodule PalauteWeb.DashboardController do
  import Ecto.Query
  use PalauteWeb, :controller
  alias Palaute.{Repo, Feedback}

  @per_page 1 
  #these should probably go somewhere else
  defp order(query, params) do
    cond do
      Dict.has_key?(params, "first") ->
        from q in query, order_by: [desc: :id]
      true ->
        from q in query, order_by: q.id
    end
  end

  defp paginate(query, params) do
    cond do
      Dict.has_key?(params, "first") ->
        from q in query, where: q.id < ^params["first"]
      Dict.has_key?(params, "last") ->
        from q in query, where: q.id > ^params["last"]
      true ->
        from q in query
    end
  end

  def index(conn, params) do
    feedback = Feedback
            |> limit(@per_page)
            |> order(params)
            |> paginate(params)
            |> Repo.all()
	
    render conn, "index.html", feedback: feedback
  end
end
