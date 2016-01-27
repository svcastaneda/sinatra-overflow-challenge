post '/questions/:question_id/comments/new' do
  @comment =  Comment.new(user_id: session[:user_id], body:params[:comment_text] , commentable_id: params[:question_id] , commentable_type: "Question")
  if @comment.save
    if request.xhr?
      erb :_comment_form, layout:false
    else
      redirect "questions/#{params[:question_id]}"
    end
  else
    redirect "questions/#{params[:question_id]}"
  end
end


post '/answers/:answer_id/comments/new' do
    @comment =  Comment.new(user_id: session[:user_id], body:params[:comment_text] , commentable_id: params[:question_id] , commentable_type: "Question")
  if @comment.save
    if request.xhr?
      erb :_comment_form, layout:false
    else
      redirect "answers/#{params[:answer_id]}"
    end
  else
    redirect "answers/#{params[:answer_id]}"
  end
end
