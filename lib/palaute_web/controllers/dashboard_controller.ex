defmodule PalauteWeb.DashboardController do
  import Ecto.Query
  use PalauteWeb, :controller
  alias Palaute.{Repo, Feedback}

  @per_page 25
  #these should probably go somewhere else
  defp order(query, params) do
        from q in query, order_by: q.id
  end

  defp paginate(query, params) do
    cond do
      Map.has_key?(params, "first") ->
        from q in query, where: q.id < ^params["first"]
      Map.has_key?(params, "last") ->
        from q in query, where: q.id > ^params["last"]
      true ->
        from q in query
    end
  end

  def query(params) do
    Feedback
            |> limit(^Map.get(params, "limit"))
            |> order(params)
            |> paginate(params)
            |> Repo.all()
  end

  #not sure if this is the best way to change 
  def switch(map, oldkey, newkey, trans) do
    {value, new_map} = Map.pop(map, oldkey)
    Map.put(new_map, newkey, trans.(value))
  end

  def incr(a) do
    {val, _} = Integer.parse(a)
    val + 1
  end

  def decr(a) do
    {val, _} = Integer.parse(a)
    val - 1
  end

  def requery(params) do
    cond do
      Map.has_key?(params, "first") ->
        query(switch(params, "first", "last", &decr/1))
      Map.has_key?(params, "last") ->
        query(switch(params, "last", "first", &incr/1))
    end
  end

  def peak_forwards(params, idx) do
    length(query(Map.merge(params, %{"last": idx, "limit": 1}))) > 0
  end

  def peak_backwards(params, idx) do
    length(query(Map.merge(params, %{"first": idx, "limit": 1}))) > 0
  end

  def can_forward(params, set) do
    peak_forwards(params,
      set
        |> Enum.take(-1)
        |> hd
        |> Map.get(:id)
    )
  end

  def can_back(params, set) do
    peak_backwards(params, hd(set) |> Map.get(:id) )
  end

  def index(conn, params) do
    param_limit = Map.put_new(params, "limit", @per_page)
    feedback = query(param_limit)
    if length(feedback) != 0 do
      can_back = can_back(params, feedback)
      can_forward = can_forward(params, feedback)
      render conn, "index.html", feedback: feedback,
      can_back: can_back,
      can_forward: can_forward
    else
      feedback_ = requery(param_limit)
      can_back = can_back(params, feedback_)
      can_forward = can_forward(params, feedback_)
      render conn, "index.html", feedback: feedback_,
      can_back: can_back,
      can_forward: can_forward
    end
  end
end
