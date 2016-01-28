post '/questions/:question_id/votes/:value' do
  if request.xhr?
    vote = Vote.create(user_id: current_user.id, value: params[:value], voteable_type: "Question", voteable_id: params[:question_id])
    content_type :json
    {value: vote.value}.to_json
  else
    redirect "/question/#{params[:question_id]}"
  end
end

post '/answers/:answer_id/votes/new/:value' do
  if request.xhr?
    answer = Answer.find(params[:answer_id])
    p params[:value]
    vote = answer.votes.create(user_id: current_user.id, value: params[:value]) if current_user
    
    content_type :json
    {vote_value: vote.value}.to_json
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