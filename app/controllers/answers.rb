post '/questions/:question_id/answers' do
  if current_user
    @user = User.find(session[:user_id])
    @answer = Answer.new(user_id: current_user.id, question_id: params[:question_id], body: params[:answer_text])
    if @answer.save
      redirect "/questions/#{@answer.question.id}"
    else
      @errors = answer.errors.full_messages
      erb :'/answer/errors'
    end
  else
    redirect "/user/login"
  end
end