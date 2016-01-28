post '/questions/:question_id/comments/new' do
  @comment =  Comment.new(user_id: session[:user_id], body:params[:comment_text] , commentable_id: params[:question_id] , commentable_type: "Question")
  if @comment.save
    if request.xhr?
      erb :"partials/_comment_show", layout:false, locals: {comment: @comment, comment_form_name: "comment"}
    else
      redirect "questions/#{params[:question_id]}"
    end
  else
    redirect "questions/#{params[:question_id]}"
  end
end


post '/answers/:answer_id/comments/new' do
  p params
    @comment =  Comment.new(user_id: session[:user_id], body:params[:comment_text] , commentable_id: params[:answer_id] , commentable_type: "Answer")
  if @comment.save
    if request.xhr?
      erb :"partials/_comment_show", layout:false, locals: {comment: @comment, comment_form_name: "comment"}
    else
      redirect "answers/#{params[:answer_id]}"
    end
  else
    redirect "answers/#{params[:answer_id]}"
  end
end
