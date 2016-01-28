post '/questions/:question_id/votes/new/:type' do
  question = Question.find(params[:question_id])
    value = vote_value(params[:type])

  if request.xhr?
    current_user.votes.each do |vote|
      if vote.voteable_id == question.id
        You
        return true
      end
    end
    question.votes.create(user_id: current_user.id, value: value) if current_user
    content_type :json
    {score: score(question)}.to_json
  else
    redirect "/question/#{params[:question_id]}"
  end
end

post '/answers/:answer_id/votes/new/:type' do
  answer = Answer.find(params[:answer_id])
  value = vote_value(params[:type])
  if request.xhr?
    current_user.votes.each do |vote|
      if vote.voteable_id == answer.id
        You
        return true
      end
    end
    answer.votes.create(user_id: current_user.id, value: value) if current_user

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