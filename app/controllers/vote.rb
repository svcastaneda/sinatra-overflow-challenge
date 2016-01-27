post 'question/:question_id/votes' do
  if request.xhr?
    Vote.create(user_id: session[:id], value: params[:value], voteable_type: "Question", voteable_id: params[:question_id])
  else
    Vote.create(user_id: session[:id], value: params[:value], voteable_type: "Question", voteable_id: params[:question_id])
    redirect "/question/#{params[:question_id]}"
  end
end

post 'answer/:answer_id/votes' do
  if request.xhr?
    Vote.create(user_id: session[:id], value: params[:value], voteable_type: "Answer", voteable_id: params[:answer_id])
  else
    Vote.create(user_id: session[:id], value: params[:value], voteable_type: "Answer", voteable_id: params[:answer_id])
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