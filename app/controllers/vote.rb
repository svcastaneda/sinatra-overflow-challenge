post '/questions/:question_id/votes/new/:type' do
  question = Question.find(params[:question_id])
  value = vote_value(params[:type])
  new_vote = question.votes.new(user_id: current_user.id, value: value) if current_user

  if request.xhr?
   if Vote.exists?(user_id: current_user.id, voteable_id: question.id, voteable_type: "Question")
    sum = 0
    current_user.votes.where(voteable_id: question.id, voteable_type: "Question").each do |vote|
      sum += vote.value
    end
    if (sum + value) > 1 || (sum + value) < -1
      return true
    end
   end
    new_vote.save!
    content_type :json
    {score: score(question)}.to_json
  else
    redirect "/question/#{params[:question_id]}"
  end
end

post '/answers/:answer_id/votes/new/:type' do
  answer = Answer.find(params[:answer_id])
  value = vote_value(params[:type])
  new_answer = answer.votes.new(user_id: current_user.id, value: value) if current_user
  if request.xhr?
    if Vote.exists?(user_id: current_user.id, voteable_id: answer.id, voteable_type: "Answer")
    sum = 0
    current_user.votes.where(voteable_id: answer.id, voteable_type: "Answer").each do |vote|
      sum += vote.value
    end
    if (sum + value) > 1 || (sum + value) < -1
      return true
    end
   end
    new_answer.save!
    content_type :json
    {score: score(answer)}.to_json
  else
    redirect "/question/#{params[:question_id]}"
  end
end


# HTTP Request Type Path  View File Description
# GET '/votes'  '/votes/index'  display a list of all votes
# GET '/votes/new'  '/votes/new'  return a HTML form for creating new votes
# POST  '/votes'  '/votes/create' create new votes
# GET '/votes/:id'  '/votes/show' display specific votes
# GET '/votes/:id/edit' '/votes/edit' display page with edit votes
# PUT/PATCH '/votes/:id'  '/votes/update' return a HTML form for editing votes
# DELETE  '/votes/:id'  '/votes/destroy'  delete specific votes