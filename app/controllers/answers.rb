post '/questions/:question_id/answers' do
  if current_user
    @user = User.find(session[:user_id])
    @answer = Answer.new(user_id: current_user.id, question_id: params[:question_id], body: params[:answer_text])
    @question = Question.find(params[:question_id])
    if @answer.save
      if request.xhr?
        erb :'/partials/_answer_show', locals: {answer: @answer, question: @question}, layout: false
      else
        redirect "/questions/#{@answer.question.id}"
      end
    else
      @errors = answer.errors.full_messages
      erb :'/answer/errors'
    end
  else
    redirect "/user/login"
  end
end

put '/answers/:answer_id' do
  @answer = Answer.find(params[:answer_id])


  if params[:starred] == 'true'
    if @answer.question.answers.pluck('starred').include?(true)
      @star_status = false
      error 422 if request.xhr?
    else
      @star_status = true
    end
  elsif params[:starred] == 'false'
    @star_status = false
  end

    @answer.update_attribute(:starred, @star_status)
    if request.xhr? == false
    @question = Question.find(params[:question_id])
    erb :'questions/show'
    end
  end
