get '/questions/:id' do
  if @question = Question.find(params[:id])
    p @answers = @question.answers
    erb :'questions/show'
  else #make this work
    erb :'errors/404'
  end
end