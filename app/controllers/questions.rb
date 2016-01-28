get '/questions/?' do
  @questions = Question.order(created_at: :desc, id: :desc).limit(20)
  erb :index
end

get '/questions/new' do
  erb :'questions/new'
end

post '/questions' do
  if current_user
    @user = User.find(session[:id])
    @question = Question.new(user_id: current_user.id, title: params[:question_title], body: params[:question_body])
    if question.save
      redirect "/questions/#{question.id}"
    else
      @errors = question.errors.full_messages
      erb :'/questions/errors'
    end
  else
    redirect "/user/login"
  end
end

get '/questions/:q_id' do
  p @question = Question.find(params[:q_id])
  if @question
    p @answers = @question.answers
    erb :'questions/show'
  else #make this work
    erb :'errors/404'
  end
end

# HTTP Request Type Path  View File Description
# GET '/questions'  '/questions/index'  display a list of all questions
# GET '/questions/new'  '/questions/new'  return a HTML form for creating new questions
# POST  '/questions'  '/questions/create' create new questions
# GET '/questions/:id'  '/questions/show' display specific questions
# GET '/questions/:id/edit' '/questions/edit' display page with edit questions
# PUT/PATCH '/questions/:id'  '/questions/update' return a HTML form for editing questions
# DELETE  '/questions/:id'  '/questions/destroy'  delete specific questions

