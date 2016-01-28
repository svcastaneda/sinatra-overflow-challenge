helpers do
  def score(object)
    object.votes.pluck('value').sum
  end

  def vote_value(type)
    if type == "upvote"
      1
    elsif type == "downvote"
      -1
    end
  end
end