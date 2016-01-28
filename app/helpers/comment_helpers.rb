def score(comment)
  comment.votes.pluck('value').sum(&:to_i)
end